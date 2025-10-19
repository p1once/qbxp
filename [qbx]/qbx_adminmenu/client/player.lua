local selectedPlayer
local itemOptionsCache

local giveItemCategoryContextId = 'qbx_adminmenu_giveitem_categories'
local giveItemContextPrefix = 'qbx_adminmenu_giveitem_items_'

local currentCategoryFilter
local currentCategoryFilterRaw
local currentItemFilters = {}

local function openExtraMenu()
    lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
end

local function sanitizeContextId(id)
    local sanitized = id:gsub('[^%w]+', '_')
    if sanitized == '' then
        sanitized = 'default'
    end
    return sanitized
end

local function determineItemCategory(itemName, itemData)
    if itemData then
        local category = itemData.category or itemData.type

        if not category then
            local clientData = itemData.client
            if type(clientData) == 'table' then
                category = clientData.category
            end
        end

        if category then
            category = tostring(category)
            category = category:gsub('^%s+', ''):gsub('%s+$', '')
            if category ~= '' then
                return category
            end
        end
    end

    local lowerName = itemName:lower()
    if lowerName:find('weapon_', 1, true) then
        return 'Weapons'
    end

    if lowerName:find('ammo', 1, true) then
        return 'Ammunition'
    end

    local label = itemData and itemData.label or itemName
    local firstLetter = label and label:match('%a') or itemName:match('%a')

    if not firstLetter then
        return '#'
    end

    return firstLetter:upper()
end

local function prettifyCategoryName(category)
    if category == '#' then
        return 'Miscellaneous'
    end

    if #category == 1 then
        return category:upper()
    end

    local formatted = category:gsub('_', ' ')
    formatted = formatted:gsub('%s+', ' ')

    formatted = formatted:gsub('(%a)(%w*)', function(first, rest)
        return first:upper() .. rest:lower()
    end)

    return formatted
end

local function getItemOptions()
    if itemOptionsCache then
        return itemOptionsCache
    end

    local items = exports.ox_inventory:Items()
    if not items then
        return nil
    end

    local categories = {}

    for itemName, itemData in pairs(items) do
        local categoryValue = determineItemCategory(itemName, itemData)
        local categoryEntry = categories[categoryValue]

        if not categoryEntry then
            local displayName = prettifyCategoryName(categoryValue)
            categoryEntry = {
                display = displayName,
                items = {},
            }
            categoryEntry.shortcut = (displayName:match('%a') or categoryValue:match('%a') or '#'):upper()
            categories[categoryValue] = categoryEntry
        end

        local displayLabel = itemData and itemData.label or itemName
        local fullLabel = itemData and itemData.label and string.format('%s (%s)', itemData.label, itemName) or itemName
        local shortcut = (displayLabel and displayLabel:match('%a') or itemName:match('%a') or '#'):upper()

        categoryEntry.items[#categoryEntry.items + 1] = {
            value = itemName,
            display = displayLabel or itemName,
            fullLabel = fullLabel,
            normalized = (fullLabel .. ' ' .. itemName):upper(),
            shortcut = shortcut
        }
    end

    local categoryList = {}
    local itemsByCategory = {}

    for categoryValue, categoryData in pairs(categories) do
        table.sort(categoryData.items, function(a, b)
            return a.fullLabel < b.fullLabel
        end)

        itemsByCategory[categoryValue] = {
            items = categoryData.items,
            display = categoryData.display,
            shortcut = categoryData.shortcut,
            count = #categoryData.items
        }

        categoryList[#categoryList + 1] = {
            value = categoryValue,
            display = categoryData.display,
            normalized = (categoryData.display .. ' ' .. categoryValue):upper(),
            shortcut = categoryData.shortcut,
            count = #categoryData.items
        }
    end

    table.sort(categoryList, function(a, b)
        local aDisplay = a.display:lower()
        local bDisplay = b.display:lower()

        if aDisplay == bDisplay then
            return a.display < b.display
        end

        return aDisplay < bDisplay
    end)

    itemOptionsCache = {
        categories = categoryList,
        items = itemsByCategory
    }

    return itemOptionsCache
end

local showGiveItemCategoryMenu

local function showGiveItemList(categoryValue, filterTerm)
    local cache = getItemOptions()
    if not cache or not cache.items or not cache.items[categoryValue] then
        exports.qbx_core:Notify('No items found for this category', 'error')
        showGiveItemCategoryMenu(currentCategoryFilterRaw)
        return
    end

    if filterTerm ~= nil then
        local trimmed = filterTerm:gsub('^%s+', ''):gsub('%s+$', '')
        if trimmed == '' then
            filterTerm = nil
            currentItemFilters[categoryValue] = nil
        else
            filterTerm = trimmed
            currentItemFilters[categoryValue] = trimmed
        end
    else
        currentItemFilters[categoryValue] = nil
    end

    local normalizedFilter = filterTerm and filterTerm:upper()
    local filterIsLetter = normalizedFilter and #normalizedFilter == 1 or false

    local categoryData = cache.items[categoryValue]
    if categoryData.count == 0 then
        exports.qbx_core:Notify('No items available in this category', 'error')
        showGiveItemCategoryMenu(currentCategoryFilterRaw)
        return
    end

    local options = {
        {
            title = '🔎 Quick Search',
            description = 'Filter items by typing a letter or keyword.',
            onSelect = function()
                local input = lib.inputDialog(('Search items - %s'):format(categoryData.display), {{
                    type = 'input',
                    label = 'Letter or keyword',
                    description = 'Leave empty to reset the filter'
                }})

                if not input then
                    showGiveItemList(categoryValue, currentItemFilters[categoryValue])
                    return
                end

                local search = input[1]
                if search then
                    search = search:gsub('^%s+', ''):gsub('%s+$', '')
                end

                if search and search ~= '' then
                    showGiveItemList(categoryValue, search)
                else
                    showGiveItemList(categoryValue)
                end
            end
        }
    }

    local matches = 0
    for _, item in ipairs(categoryData.items) do
        local include = true

        if normalizedFilter then
            include = item.normalized:find(normalizedFilter, 1, true) ~= nil

            if not include and filterIsLetter then
                include = item.shortcut == normalizedFilter
            end
        end

        if include then
            matches += 1
            options[#options + 1] = {
                title = item.fullLabel,
                metadata = {
                    ('Shortcut: %s'):format(item.shortcut),
                    ('Internal name: %s'):format(item.value)
                },
                onSelect = function()
                    local quantityDialog = lib.inputDialog(('Give %s'):format(item.fullLabel), {{
                        type = 'number',
                        label = 'Amount',
                        min = 1,
                        default = 1
                    }})

                    if not quantityDialog then
                        showGiveItemList(categoryValue, currentItemFilters[categoryValue])
                        return
                    end

                    local amount = math.floor(tonumber(quantityDialog[1]) or 0)
                    if amount < 1 then
                        exports.qbx_core:Notify('Invalid amount', 'error')
                        showGiveItemList(categoryValue, currentItemFilters[categoryValue])
                        return
                    end

                    ExecuteCommand(('giveitem %s %s %d'):format(selectedPlayer.id, item.value, amount))
                    openExtraMenu()
                end
            }
        end
    end

    if matches == 0 then
        if filterTerm then
            exports.qbx_core:Notify(('No items found for "%s"'):format(filterTerm), 'error')
            showGiveItemList(categoryValue)
        else
            exports.qbx_core:Notify('No items available in this category', 'error')
            showGiveItemCategoryMenu(currentCategoryFilterRaw)
        end
        return
    end

    local contextId = giveItemContextPrefix .. sanitizeContextId(categoryValue)

    lib.registerContext({
        id = contextId,
        title = ('%s (%d items)'):format(categoryData.display, categoryData.count),
        menu = giveItemCategoryContextId,
        options = options,
        onBack = function()
            showGiveItemCategoryMenu(currentCategoryFilterRaw)
        end,
        onExit = function()
            openExtraMenu()
        end
    })

    lib.showContext(contextId)
end

showGiveItemCategoryMenu = function(filterTerm)
    if filterTerm ~= nil then
        local trimmed = filterTerm:gsub('^%s+', ''):gsub('%s+$', '')
        if trimmed == '' then
            currentCategoryFilter = nil
            currentCategoryFilterRaw = nil
        else
            currentCategoryFilter = trimmed:upper()
            currentCategoryFilterRaw = trimmed
        end
    else
        currentCategoryFilter = nil
        currentCategoryFilterRaw = nil
    end

    local cache = getItemOptions()
    if not cache or not cache.categories or #cache.categories == 0 then
        exports.qbx_core:Notify('No item data available', 'error')
        openExtraMenu()
        return
    end

    local normalizedFilter = currentCategoryFilter
    local filterIsLetter = normalizedFilter and #normalizedFilter == 1 or false

    local options = {
        {
            title = '🔎 Quick Search',
            description = 'Filter categories by typing a letter or keyword.',
            onSelect = function()
                local input = lib.inputDialog('Search categories', {{
                    type = 'input',
                    label = 'Letter or keyword',
                    description = 'Leave empty to show all categories'
                }})

                if not input then
                    showGiveItemCategoryMenu(currentCategoryFilterRaw)
                    return
                end

                local search = input[1]
                if search then
                    search = search:gsub('^%s+', ''):gsub('%s+$', '')
                end

                if search and search ~= '' then
                    showGiveItemCategoryMenu(search)
                else
                    showGiveItemCategoryMenu()
                end
            end
        }
    }

    local matches = 0

    for _, category in ipairs(cache.categories) do
        local include = true

        if normalizedFilter then
            include = category.normalized:find(normalizedFilter, 1, true) ~= nil

            if not include and filterIsLetter then
                include = category.shortcut == normalizedFilter
            end
        end

        if include then
            matches += 1
            options[#options + 1] = {
                title = ('%s (%d)'):format(category.display, category.count),
                metadata = {
                    ('Shortcut: %s'):format(category.shortcut)
                },
                onSelect = function()
                    showGiveItemList(category.value, currentItemFilters[category.value])
                end
            }
        end
    end

    if matches == 0 then
        if filterTerm then
            exports.qbx_core:Notify(('No categories found for "%s"'):format(filterTerm), 'error')
        end

        showGiveItemCategoryMenu()
        return
    end

    lib.registerContext({
        id = giveItemCategoryContextId,
        title = 'Give Item - Categories',
        options = options,
        onBack = function()
            openExtraMenu()
        end,
        onExit = function()
            openExtraMenu()
        end
    })

    lib.showContext(giveItemCategoryContextId)
end
local playerOptions = {
    function()
        lib.showMenu('qbx_adminmenu_player_general_menu', MenuIndexes.qbx_adminmenu_player_general_menu)
    end,
    function()
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    end,
    function()
        lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
    end,
    function()
        local input = lib.inputDialog('Name Change', {'Firstname', 'Lastname'})
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'name', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Food', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'food', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Thirst', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'thirst', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Stress', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'stress', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Armor', {
            {type = 'number', label = 'Percentage', min = 0, max = 100}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'armor', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Phone', {'Number'})
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'phone', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Crafting', {
            {type = 'number', label = 'Reputation'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'crafting', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Dealer', {
            {type = 'number', label = 'Reputation'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'dealer', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Money', {
            {type = 'number', label = 'Cash'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'cash', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Money', {
            {type = 'number', label = 'Bank'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'bank', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local jobData = lib.callback.await('qbx_admin:server:getJobOptions', false)

        if not jobData or not jobData.jobs or #jobData.jobs == 0 then
            exports.qbx_core:Notify('No job data available', 'error')
            GeneratePlayersMenu()
            return
        end

        local jobSelection = lib.inputDialog('Job', {
            {
                type = 'select',
                label = 'Job',
                options = jobData.jobs
            }
        })

        if not jobSelection then
            GeneratePlayersMenu()
            return
        end

        local selectedJob = jobSelection[1]
        local gradeOptions = selectedJob and jobData.grades[selectedJob] or nil

        if not selectedJob or not gradeOptions or #gradeOptions == 0 then
            exports.qbx_core:Notify('No grades available for this job', 'error')
            GeneratePlayersMenu()
            return
        end

        local gradeSelection = lib.inputDialog('Job Grade', {
            {
                type = 'select',
                label = 'Grade',
                options = gradeOptions
            }
        })

        if not gradeSelection then
            GeneratePlayersMenu()
            return
        end

        local selectedGrade = tonumber(gradeSelection[1]) or 0

        TriggerServerEvent('qbx_admin:server:changePlayerData', 'job', selectedPlayer, {selectedJob, selectedGrade})
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Gang', {
            {type = 'input', label = 'Name'},
            {type = 'number', label = 'Grade'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'gang', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local input = lib.inputDialog('Radio', {
            {type = 'number', label = 'Frequency'}
        })
        if not input then GeneratePlayersMenu() return end
        TriggerServerEvent('qbx_admin:server:changePlayerData', 'radio', selectedPlayer, input)
        GeneratePlayersMenu()
    end,
    function()
        local license = selectedPlayer.license:gsub('license:', '')
        lib.setClipboard(license)
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id)])
    end,
    function()
        local discord = selectedPlayer.discord:gsub('discord:', '')
        lib.setClipboard(discord)
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id)])
    end,
    function()
        local steam = selectedPlayer.steam:gsub('steam:', '')
        lib.setClipboard(steam)
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer.id)])
    end,
}

function GeneratePlayersMenu()
    local players = lib.callback.await('qbx_admin:server:getPlayers', false)
    if not players then
        lib.showMenu('qbx_adminmenu_main_menu', MenuIndexes.qbx_adminmenu_main_menu)
        return
    end
    local optionsList = {}
    for i = 1, #players do
        optionsList[#optionsList + 1] = {label = string.format('ID: %s | Name: %s', players[i].id, players[i].name), description = string.format('CID: %s', players[i].cid), args = {players[i]}}
    end
    lib.registerMenu({
        id = 'qbx_adminmenu_players_menu',
        title = locale('title.players_menu'),
        position = 'top-right',
        onClose = function(keyPressed)
            CloseMenu(false, keyPressed, 'qbx_adminmenu_main_menu')
        end,
        onSelected = function(selected)
            MenuIndexes.qbx_adminmenu_players_menu = selected
        end,
        options = optionsList
    }, function(_, _, args)
        local player = lib.callback.await('qbx_admin:server:getPlayer', false, args[1].id)
        if not player then
            lib.showMenu('qbx_adminmenu_main_menu', MenuIndexes.qbx_adminmenu_main_menu)
            return
        end
        lib.registerMenu({
            id = ('qbx_adminmenu_player_menu_%s'):format(args[1].id),
            title = player.name,
            position = 'top-right',
            onClose = function(keyPressed)
                CloseMenu(false, keyPressed, 'qbx_adminmenu_players_menu')
            end,
            onSelected = function(selected)
                MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(args[1].id)] = selected
            end,
            options = {
                {label = locale('player_options.label1'), description = locale('player_options.desc1'), icon = 'fas fa-wrench'},
                {label = locale('player_options.label2'), description = locale('player_options.desc2'), icon = 'fas fa-file-invoice'},
                {label = locale('player_options.label3'), description = locale('player_options.desc3'), icon = 'fas fa-gamepad'},
                {label = string.format('Name: %s', player.name)},
                {label = string.format('Food: %s', player.food)},
                {label = string.format('Water: %s', player.water)},
                {label = string.format('Stress: %s', player.stress)},
                {label = string.format('Armor: %s', player.armor)},
                {label = string.format('Phone: %s', player.phone)},
                {label = string.format('Crafting Rep: %s', player.craftingrep)},
                {label = string.format('Dealer Rep: %s', player.dealerrep)},
                {label = string.format('Cash: %s', lib.math.groupdigits(player.cash))},
                {label = string.format('Bank: %s', lib.math.groupdigits(player.bank))},
                {label = string.format('Job: %s', player.job)},
                {label = string.format('Gang: %s', player.gang)},
                {label = string.format('Radio: %s', Player(args[1].id).state.radioChannel)},
                {label = string.format('%s', player.license), description = 'License'},
                {label = string.format('%s', player.discord), description = 'Discord'},
                {label = string.format('%s', player.steam), description = 'Steam'}
            }
        }, function(selected)
            playerOptions[selected]()
        end)
        selectedPlayer = player
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(args[1].id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(args[1].id)])
    end)
    lib.showMenu('qbx_adminmenu_players_menu', MenuIndexes.qbx_adminmenu_players_menu)
end

lib.registerMenu({
    id = 'qbx_adminmenu_player_general_menu',
    title = locale('player_options.label1'),
    position = 'top-right',
    onClose = function(keyPressed)
        CloseMenu(false, keyPressed, ('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id))
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_player_general_menu = selected
    end,
    options = {
        {label = locale('player_options.general.labelkill'), description = locale('player_options.general.desckill'), icon = 'fas fa-skull', close = false},
        {label = locale('player_options.general.labelrevive'), description = locale('player_options.general.descrevive'), icon = 'fas fa-cross', close = false},
        {label = locale('player_options.general.labelfreeze'), description = locale('player_options.general.descfreeze'), icon = 'fas fa-icicles', close = false},
        {label = locale('player_options.general.labelgoto'), description = locale('player_options.general.descgoto'), icon = 'fas fa-arrow-right-long', close = false},
        {label = locale('player_options.general.labelbring'), description = locale('player_options.general.descbring'), icon = 'fas fa-arrow-left-long', close = false},
        {label = locale('player_options.general.labelsitinveh'), description = locale('player_options.general.descsitinveh'), icon = 'fas fa-chair', close = false},
        {label = locale('player_options.general.labelrouting'), description = locale('player_options.general.descrouting'), icon = 'fas fa-bucket'},
    }
}, function(selected)
    if selected == 7 then
        local input = lib.inputDialog(selectedPlayer.name, {
            {type = 'number', label = locale('player_options.general.labelrouting'), placeholder = '25'}
        })
        if not input then return end if not input[1] then return end
        TriggerServerEvent('qbx_admin:server:playerOptionsGeneral', selected, selectedPlayer, input[1])
        lib.showMenu(('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id), MenuIndexes[('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id)])
    else
        TriggerServerEvent('qbx_admin:server:playerOptionsGeneral', selected, selectedPlayer)
    end
end)

lib.registerMenu({
    id = 'qbx_adminmenu_player_administration_menu',
    title = locale('player_options.label2'),
    position = 'top-right',
    onClose = function(keyPressed)
        CloseMenu(false, keyPressed, ('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id))
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_player_administration_menu = selected
    end,
    options = {
        {label = locale('player_options.administration.labelkick'), description = locale('player_options.administration.desckick'), icon = 'fas fa-plane-departure'},
        {label = locale('player_options.administration.labelban'), description = locale('player_options.administration.descban'), icon = 'fas fa-gavel'},
        {label = locale('player_options.administration.labelperm'), description = locale('player_options.administration.descperm'), values = {locale('player_options.administration.permvalue1'),
        locale('player_options.administration.permvalue2'), locale('player_options.administration.permvalue3'), locale('player_options.administration.permvalue4')}, args = {'remove', 'mod', 'admin', 'god'}, icon = 'fas fa-book-bookmark'},
    }
}, function(selected, scrollIndex, args)
    if selected == 1 then
        local input = lib.inputDialog(selectedPlayer.name, {locale('player_options.administration.inputkick')})
        if not input then lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu) return end if not input[1] then return end
        TriggerServerEvent('qbx_admin:server:playerAdministration', selected, selectedPlayer, input[1])
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    elseif selected == 2 then
        local input = lib.inputDialog(selectedPlayer.name, {
            { type = 'input', label = locale('player_options.administration.inputkick'), placeholder = 'VDM'},
            { type = 'number', label = locale('player_options.administration.input1ban')},
            { type = 'number', label = locale('player_options.administration.input2ban')},
            { type = 'number', label = locale('player_options.administration.input3ban')}
        })
        if not input then lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_general_menu) return end if not input[1] or not input[2] and not input[3] and not input[4] then return end
        TriggerServerEvent('qbx_admin:server:playerAdministration', selected, selectedPlayer, input)
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    else
        TriggerServerEvent('qbx_admin:server:playerAdministration', selected, selectedPlayer, args[scrollIndex])
        lib.showMenu('qbx_adminmenu_player_administration_menu', MenuIndexes.qbx_adminmenu_player_administration_menu)
    end
end)

lib.registerMenu({
    id = 'qbx_adminmenu_player_extra_menu',
    title = locale('player_options.label2'),
    position = 'top-right',
    onClose = function(keyPressed)
        CloseMenu(false, keyPressed, ('qbx_adminmenu_player_menu_%s'):format(selectedPlayer?.id))
    end,
    onSelected = function(selected)
        MenuIndexes.qbx_adminmenu_player_extra_menu = selected
    end,
    options = {
        {label = 'Open Inventory'},
        {label = 'Give Clothing Menu'},
        {label = 'Give Item'},
        {label = 'Mute'}
    }
}, function(selected)
    if selected == 1 then
        exports.ox_inventory:openInventory('player', selectedPlayer.id)
    elseif selected == 2 then
        local succeeded = lib.callback.await('qbx_admin:server:clothingMenu', false, selectedPlayer.id)
        if succeeded then return end
        lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
    elseif selected == 3 then
        local itemData = getItemOptions()

        if not itemData or not itemData.categories or #itemData.categories == 0 then
            exports.qbx_core:Notify('No item data available', 'error')
            lib.showMenu('qbx_adminmenu_player_extra_menu', MenuIndexes.qbx_adminmenu_player_extra_menu)
            return
        end

        lib.hideMenu()
        showGiveItemCategoryMenu(currentCategoryFilterRaw)
    elseif selected == 4 then
        exports['pma-voice']:toggleMutePlayer(selectedPlayer.id)
    end
end)

RegisterNetEvent('ox_inventory:itemList', function()
    itemOptionsCache = nil
end)

RegisterNetEvent('qbx_admin:client:killPlayer', function()
    SetEntityHealth(cache.ped, 0)
end)
