local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = {}
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = L0_1
    L1_2[A0_2] = 0
  end
  L1_2 = L0_1
  L2_2 = L1_2[A0_2]
  L2_2 = L2_2 + 1
  L1_2[A0_2] = L2_2
  L1_2 = Citizen
  L1_2 = L1_2.SetTimeout
  L2_2 = 3000
  function L3_2()
    local L0_3, L1_3, L2_3
    L1_3 = A0_2
    L0_3 = L0_1
    L2_3 = L0_3[L1_3]
    L2_3 = L2_3 - 1
    L0_3[L1_3] = L2_3
    L1_3 = A0_2
    L0_3 = L0_1
    L0_3 = L0_3[L1_3]
    if L0_3 <= 0 then
      L1_3 = A0_2
      L0_3 = L0_1
      L0_3[L1_3] = nil
    end
  end
  L1_2(L2_2, L3_2)
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if L1_2 > 15 then
    L1_2 = true
    return L1_2
  end
  L1_2 = false
  return L1_2
end
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:queryShop"
function L4_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L4_2 = source
  L5_2 = L1_1
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  if L5_2 then
    L5_2 = TriggerClientEvent
    L6_2 = "rcore_clothing:queryShopResponse"
    L7_2 = L4_2
    L8_2 = A0_2
    L9_2 = "ratelimited"
    L5_2(L6_2, L7_2, L8_2, L9_2)
    return
  end
  L5_2 = FwGetPlayerJobData
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2.name
  L7_2 = L5_2.grade
  L8_2 = GetPlayerFwIdentifier
  L9_2 = L4_2
  L8_2 = L8_2(L9_2)
  L9_2 = AppendAces
  L10_2 = L4_2
  L11_2 = GetPlayerIdentifiers
  L12_2 = L4_2
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L11_2(L12_2)
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L10_2 = A3_2.shopConfig
  L11_2 = L10_2 or L11_2
  if L10_2 then
    L11_2 = L10_2.modifiers
    if L11_2 then
      L11_2 = L10_2.modifiers
      L12_2 = SHOP_MODIFIERS
      L12_2 = L12_2.CHANGING_ROOM
      L11_2 = L11_2[L12_2]
    end
  end
  L12_2 = L10_2 or L12_2
  if L10_2 then
    L12_2 = L10_2.modifiers
    if L12_2 then
      L12_2 = L10_2.modifiers
      L13_2 = SHOP_MODIFIERS
      L13_2 = L13_2.HAS_EVERYTHING
      L12_2 = L12_2[L13_2]
    end
  end
  L13_2 = L10_2 or L13_2
  if L10_2 then
    L13_2 = L10_2.modifiers
    if L13_2 then
      L13_2 = L10_2.modifiers
      L14_2 = SHOP_MODIFIERS
      L14_2 = L14_2.IS_EVERYTHING_FREE
      L13_2 = L13_2[L14_2]
    end
  end
  L14_2 = {}
  L15_2 = A3_2.componentId
  if 33 == L15_2 then
    L15_2 = print
    L16_2 = "this shouldnt hit backend component"
    L17_2 = A3_2.componentId
    L15_2(L16_2, L17_2)
  else
    A3_2.job = L6_2
    A3_2.jobGrade = L7_2
    A3_2.identifiers = L9_2
    A3_2.showEverything = L12_2
    A3_2.showAll = false
    L15_2 = L8_2 or L15_2
    if not L11_2 or not L8_2 then
      L15_2 = nil
    end
    A3_2.changingRoomIdentifier = L15_2
    L15_2 = QueryShopFromDb
    L16_2 = A1_2
    L17_2 = A2_2
    L18_2 = A3_2
    L15_2 = L15_2(L16_2, L17_2, L18_2)
    L14_2 = L15_2
    if L13_2 or L11_2 then
      L15_2 = pairs
      L16_2 = L14_2
      L15_2, L16_2, L17_2, L18_2 = L15_2(L16_2)
      for L19_2, L20_2 in L15_2, L16_2, L17_2, L18_2 do
        L20_2.price = 0
      end
    end
  end
  L15_2 = TriggerClientEvent
  L16_2 = "rcore_clothing:queryShopResponse"
  L17_2 = L4_2
  L18_2 = A0_2
  L19_2 = L14_2
  L15_2(L16_2, L17_2, L18_2, L19_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:queryShopAll"
function L4_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = source
  L5_2 = {}
  L6_2 = A3_2.componentId
  if 33 == L6_2 then
    L6_2 = print
    L7_2 = "this shouldnt hit backend component"
    L8_2 = A3_2.componentId
    L6_2(L7_2, L8_2)
  else
    A3_2.job = nil
    A3_2.jobGrade = nil
    A3_2.identifiers = nil
    A3_2.showEverything = false
    A3_2.showAll = true
    A3_2.changingRoomIdentifier = nil
    L6_2 = QueryShopFromDb
    L7_2 = A1_2
    L8_2 = A2_2
    L9_2 = A3_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L5_2 = L6_2
  end
  L6_2 = TriggerClientEvent
  L7_2 = "rcore_clothing:queryShopResponse"
  L8_2 = L4_2
  L9_2 = A0_2
  L10_2 = L5_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
end
L2_1(L3_1, L4_1)
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L3_2 = DbGetShopItems
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = DbEnrichWithRestrictions
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L3_2 = L4_2
  L4_2 = {}
  L5_2 = pairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = FormatClothingItem
    L12_2 = A2_2.showAll
    L13_2 = L10_2
    L14_2 = A0_2
    L11_2 = L11_2(L12_2, L13_2, L14_2)
    L12_2 = table
    L12_2 = L12_2.insert
    L13_2 = L4_2
    L14_2 = L11_2
    L12_2(L13_2, L14_2)
  end
  L5_2 = #L4_2
  if L5_2 > 0 then
    L5_2 = A2_2.componentId
    if 8 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyUndershirt
        L6_2 = A1_2
        L5_2 = L5_2(L6_2)
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 6 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyShoes
        L6_2 = A1_2
        L5_2 = L5_2(L6_2)
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 4 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyPants
        L6_2 = A1_2
        L5_2 = L5_2(L6_2)
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 1 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyMask
        L5_2 = L5_2()
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 7 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyNeckwear
        L5_2 = L5_2()
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 11 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyTorso
        L6_2 = A1_2
        L5_2 = L5_2(L6_2)
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 9 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyVest
        L6_2 = A1_2
        L5_2 = L5_2(L6_2)
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 5 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyBag
        L6_2 = A1_2
        L5_2 = L5_2(L6_2)
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 100 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyHat
        L5_2 = L5_2()
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 107 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyBracelet
        L5_2 = L5_2()
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 106 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyWatches
        L5_2 = L5_2()
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 102 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyEars
        L5_2 = L5_2()
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
    L5_2 = A2_2.componentId
    if 101 == L5_2 then
      L5_2 = A2_2.lastId
      if L5_2 < 1 then
        L5_2 = GetEmptyGlasses
        L5_2 = L5_2()
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L4_2
        L8_2 = 1
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
      end
    end
  end
  return L4_2
end
QueryShopFromDb = L2_1
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:requestOpenClothingShop"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L2_2 = source
  L3_2 = A1_2 or L3_2
  if A1_2 then
    L3_2 = A1_2.modifiers
    if L3_2 then
      L3_2 = A1_2.modifiers
      L4_2 = SHOP_MODIFIERS
      L4_2 = L4_2.CHANGING_ROOM
      L3_2 = L3_2[L4_2]
    end
  end
  L4_2 = A1_2 or L4_2
  if A1_2 then
    L4_2 = A1_2.modifiers
    if L4_2 then
      L4_2 = A1_2.modifiers
      L5_2 = SHOP_MODIFIERS
      L5_2 = L5_2.HAS_EVERYTHING
      L4_2 = L4_2[L5_2]
    end
  end
  L5_2 = GetEntityModel
  L6_2 = GetPlayerPed
  L7_2 = L2_2
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L6_2(L7_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L6_2 = GetPlayerFwIdentifier
  L7_2 = L2_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetAvailableComponentsInShop
  L8_2 = L5_2
  L9_2 = A0_2
  L10_2 = L4_2
  L11_2 = L6_2 or L11_2
  if not L3_2 or not L6_2 then
    L11_2 = nil
  end
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = GetAvailableClothingTypes
  L9_2 = L5_2
  L10_2 = A0_2
  L11_2 = L4_2
  L12_2 = L6_2 or L12_2
  if not L3_2 or not L6_2 then
    L12_2 = nil
  end
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L9_2 = FormatBaseMenuForComponents
  L10_2 = L7_2
  L9_2 = L9_2(L10_2)
  L10_2 = FormatTypesPerComponentId
  L11_2 = L8_2
  L10_2 = L10_2(L11_2)
  L11_2 = GetAllServerJobs
  L11_2 = L11_2()
  L12_2 = GetPlayerPermissions
  L13_2 = L2_2
  L12_2 = L12_2(L13_2)
  L13_2 = nil
  L14_2 = Config
  L14_2 = L14_2.ExternalServer
  if L14_2 then
    L14_2 = {}
    L15_2 = FwGetPlayerJobData
    L16_2 = L2_2
    L15_2 = L15_2(L16_2)
    L14_2.playerJobData = L15_2
    L15_2 = GetPlayerFwIdentifier
    L16_2 = L2_2
    L15_2 = L15_2(L16_2)
    L14_2.identifier = L15_2
    L15_2 = AppendAces
    L16_2 = L2_2
    L17_2 = GetPlayerIdentifiers
    L18_2 = L2_2
    L17_2, L18_2, L19_2, L20_2, L21_2 = L17_2(L18_2)
    L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L14_2.identifiers = L15_2
    L15_2 = Config
    L15_2 = L15_2.ExternalServer
    L14_2.apiUrl = L15_2
    L14_2.shopConfig = A1_2
    L13_2 = L14_2
  end
  L14_2 = TriggerClientEvent
  L15_2 = "rcore_clothing:openClothingShop"
  L16_2 = L2_2
  L17_2 = A0_2
  L18_2 = L9_2
  L19_2 = L10_2
  L20_2 = L12_2
  L21_2 = L13_2
  L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L14_2 = Wait
  L15_2 = 0
  L14_2(L15_2)
  L14_2 = TriggerClientEvent
  L15_2 = "rcore_clothing:setHairData"
  L16_2 = L2_2
  L17_2 = DbGetHair
  L18_2 = L5_2
  L17_2, L18_2, L19_2, L20_2, L21_2 = L17_2(L18_2)
  L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L14_2 = Wait
  L15_2 = 0
  L14_2(L15_2)
  L14_2 = TriggerClientEvent
  L15_2 = "rcore_clothing:setServerJobs"
  L16_2 = L2_2
  L17_2 = L11_2
  L14_2(L15_2, L16_2, L17_2)
  if "CHARCREATOR" == A0_2 then
    L14_2 = PutPlayerIntoBucket
    L15_2 = L2_2
    L14_2(L15_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:charcreator:done"
function L4_1()
  local L0_2, L1_2, L2_2
  L0_2 = source
  L1_2 = ResetPlayerBucket
  L2_2 = L0_2
  L1_2(L2_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:requestFullShopStructureExceptHead"
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = source
  L1_2 = GetEntityModel
  L2_2 = GetPlayerPed
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = GetAvailableComponentsInShop
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = GetAvailableClothingTypes
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = FormatBaseMenuForComponents
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L5_2 = FormatTypesPerComponentId
  L6_2 = L3_2
  L5_2 = L5_2(L6_2)
  L6_2 = TriggerClientEvent
  L7_2 = "rcore_clothing:setShopBaseStructure"
  L8_2 = L0_2
  L9_2 = L4_2
  L10_2 = L5_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:addItemToShop"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = AceCan
  L4_2 = L2_2
  L5_2 = Permissions
  L5_2 = L5_2.ADMIN_STOCK_MANAGEMENT
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = DbAddItemToShop
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = print
    L4_2 = "^1Player with id "
    L5_2 = L2_2
    L6_2 = " tried to add item to shop without permission."
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:removeItemFromShop"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = AceCan
  L4_2 = L2_2
  L5_2 = Permissions
  L5_2 = L5_2.ADMIN_STOCK_MANAGEMENT
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = DbRemoveItemFromShop
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = print
    L4_2 = "^1Player with id "
    L5_2 = L2_2
    L6_2 = " tried to remove item from shop without permission."
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:addGroupToShop"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = AceCan
  L4_2 = L2_2
  L5_2 = Permissions
  L5_2 = L5_2.ADMIN_STOCK_MANAGEMENT
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = DbAddGroupToShop
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = print
    L4_2 = "^1Player with id "
    L5_2 = L2_2
    L6_2 = " tried to add group to shop without permission."
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:removeGroupFromShop"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = source
  L3_2 = AceCan
  L4_2 = L2_2
  L5_2 = Permissions
  L5_2 = L5_2.ADMIN_STOCK_MANAGEMENT
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = DbRemoveGroupFromShop
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = print
    L4_2 = "^1Player with id "
    L5_2 = L2_2
    L6_2 = " tried to remove group from shop without permission."
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:editItemMetadata"
function L4_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2)
  local L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L9_2 = source
  L10_2 = AceCan
  L11_2 = L9_2
  L12_2 = Permissions
  L12_2 = L12_2.ADMIN_EDIT_METADATA
  L10_2 = L10_2(L11_2, L12_2)
  if L10_2 then
    L10_2 = DbEditItemMetadata
    L11_2 = A0_2
    L12_2 = A1_2
    L13_2 = A2_2
    L14_2 = A3_2
    L15_2 = A4_2
    L16_2 = A5_2
    L17_2 = A6_2
    L18_2 = A7_2
    L19_2 = A8_2
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  else
    L10_2 = print
    L11_2 = "^1Player with id "
    L12_2 = L9_2
    L13_2 = " tried to edit item metadata without permission."
    L11_2 = L11_2 .. L12_2 .. L13_2
    L10_2(L11_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:editGroupMetadata"
function L4_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = source
  L5_2 = AceCan
  L6_2 = L4_2
  L7_2 = Permissions
  L7_2 = L7_2.ADMIN_EDIT_METADATA
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 then
    L5_2 = DbEditGroupMetadata
    L6_2 = A0_2
    L7_2 = A1_2
    L8_2 = A2_2
    L9_2 = A3_2
    L5_2(L6_2, L7_2, L8_2, L9_2)
  else
    L5_2 = print
    L6_2 = "^1Player with id "
    L7_2 = L4_2
    L8_2 = " tried to edit group metadata without permission."
    L6_2 = L6_2 .. L7_2 .. L8_2
    L5_2(L6_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:blacklistItem"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = source
  L2_2 = AceCan
  L3_2 = L1_2
  L4_2 = Permissions
  L4_2 = L4_2.ADMIN_IMAGE_DEBUG
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = DbBlacklistItem
    L3_2 = A0_2
    L2_2(L3_2)
  else
    L2_2 = print
    L3_2 = "^1Player with id "
    L4_2 = L1_2
    L5_2 = " tried to blacklist item without permission."
    L3_2 = L3_2 .. L4_2 .. L5_2
    L2_2(L3_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:resetItem"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = source
  L2_2 = AceCan
  L3_2 = L1_2
  L4_2 = Permissions
  L4_2 = L4_2.ADMIN_IMAGE_DEBUG
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = DbResetItem
    L3_2 = A0_2
    L2_2(L3_2)
  else
    L2_2 = print
    L3_2 = "^1Player with id "
    L4_2 = L1_2
    L5_2 = " tried to reset item without permission."
    L3_2 = L3_2 .. L4_2 .. L5_2
    L2_2(L3_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:setRecommendedArms"
function L4_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = source
  L5_2 = false
  L6_2 = AceCan
  L7_2 = L4_2
  L8_2 = Permissions
  L8_2 = L8_2.ADMIN_EDIT_ARMS
  L6_2 = L6_2(L7_2, L8_2)
  if L6_2 then
    L6_2 = DbEditRecommendedArms
    L7_2 = A1_2
    L8_2 = A2_2
    L6_2(L7_2, L8_2)
    L5_2 = true
  else
    L6_2 = print
    L7_2 = "^1Player with id "
    L8_2 = L4_2
    L9_2 = " tried to edit recommended arms without permission."
    L7_2 = L7_2 .. L8_2 .. L9_2
    L6_2(L7_2)
  end
  L6_2 = TriggerClientEvent
  L7_2 = "rcore_clothing:setRecommendedArmsResult"
  L8_2 = L4_2
  L9_2 = A0_2
  L10_2 = L5_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:setGroupRecommendedArms"
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = source
  L4_2 = false
  L5_2 = AceCan
  L6_2 = L3_2
  L7_2 = Permissions
  L7_2 = L7_2.ADMIN_EDIT_ARMS
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 then
    L5_2 = DbEditGroupRecommendedArms
    L6_2 = A1_2
    L7_2 = A2_2
    L5_2(L6_2, L7_2)
    L4_2 = true
  else
    L5_2 = print
    L6_2 = "^1Player with id "
    L7_2 = L3_2
    L8_2 = " tried to edit group recommended arms without permission."
    L6_2 = L6_2 .. L7_2 .. L8_2
    L5_2(L6_2)
  end
  L5_2 = TriggerClientEvent
  L6_2 = "rcore_clothing:setRecommendedArmsResult"
  L7_2 = L3_2
  L8_2 = A0_2
  L9_2 = L4_2
  L5_2(L6_2, L7_2, L8_2, L9_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:requestCurrentOutfit"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = source
  L2_2 = GetPlayerPed
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = GetEntityModel
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetPlayerFwIdentifier
  L5_2 = L1_2
  L4_2 = L4_2(L5_2)
  L5_2 = DbGetOrCreateCurrentOutfit
  L6_2 = L4_2
  L7_2 = L3_2
  L5_2, L6_2 = L5_2(L6_2, L7_2)
  L7_2 = TriggerClientEvent
  L8_2 = "rcore_clothing:responseCurrentOutfit"
  L9_2 = L1_2
  L10_2 = A0_2
  L11_2 = {}
  L11_2.outfit = L5_2
  L11_2.model = L6_2
  L7_2(L8_2, L9_2, L10_2, L11_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:requestRecommendedArmsByHash"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = source
  L3_2 = DbGetRecommendedArmsByHash
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = TriggerClientEvent
  L5_2 = "rcore_clothing:setRecommendedArmsByHash"
  L6_2 = L2_2
  L7_2 = L3_2
  L4_2(L5_2, L6_2, L7_2)
end
L2_1(L3_1, L4_1)
