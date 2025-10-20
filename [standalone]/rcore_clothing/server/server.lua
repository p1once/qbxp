local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = {}
L1_1 = Citizen
L1_1 = L1_1.CreateThread
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = true
  L1_2 = pairs
  L2_2 = PermissionMap
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if not L0_2 then
      break
    end
    L7_2 = pairs
    L8_2 = L6_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      if not L0_2 then
        break
      end
      L13_2 = AceAllow
      L14_2 = L5_2
      L15_2 = L12_2
      L13_2(L14_2, L15_2)
      L13_2 = AceCanGroup
      L14_2 = L5_2
      L15_2 = L12_2
      L13_2 = L13_2(L14_2, L15_2)
      L0_2 = L13_2
      if not L0_2 then
        L13_2 = 1
        L14_2 = 5
        L15_2 = 1
        for L16_2 = L13_2, L14_2, L15_2 do
          L17_2 = print
          L18_2 = string
          L18_2 = L18_2.format
          L19_2 = "^1Ace Permissions failed! You probably forgot to add add_ace to server.cfg"
          L18_2, L19_2 = L18_2(L19_2)
          L17_2(L18_2, L19_2)
        end
        L13_2 = print
        L14_2 = string
        L14_2 = L14_2.format
        L15_2 = "^1https://documentation.rcore.cz/paid-resources/rcore_clothing/installation"
        L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L14_2(L15_2)
        L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
        break
      end
    end
  end
end
L1_1(L2_1)
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = Config
  L1_2 = L1_2.UseBuckets
  if not L1_2 then
    return
  end
  L1_2 = GetPlayerRoutingBucket
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L0_1
  L2_2[A0_2] = L1_2
  L2_2 = Config
  L2_2 = L2_2.BucketOffset
  if not L2_2 then
    L2_2 = 0
  end
  L3_2 = SetPlayerRoutingBucket
  L4_2 = A0_2
  L5_2 = L2_2 + A0_2
  L3_2(L4_2, L5_2)
end
PutPlayerIntoBucket = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = Config
  L1_2 = L1_2.UseBuckets
  if not L1_2 then
    return
  end
  L1_2 = SetPlayerRoutingBucket
  L2_2 = A0_2
  L3_2 = L0_1
  L3_2 = L3_2[A0_2]
  if not L3_2 then
    L3_2 = 0
  end
  L1_2(L2_2, L3_2)
  L1_2 = L0_1
  L1_2[A0_2] = nil
end
ResetPlayerBucket = L1_1
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:getSingleItemMetadata"
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L4_2 = source
  L5_2 = GetPlayerPed
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = GetEntityModel
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  L7_2 = nil
  L8_2 = Config
  L8_2 = L8_2.IdModeHasEverything
  if A2_2 then
    L8_2 = true
  end
  if L8_2 then
    L9_2 = DbGetSingleItemMetadata
    L10_2 = L6_2
    L11_2 = A1_2
    L9_2 = L9_2(L10_2, L11_2)
    L7_2 = L9_2
  else
    L9_2 = DbGetSingleItemMetadataForShop
    L10_2 = L6_2
    L11_2 = A1_2
    L12_2 = A0_2
    L13_2 = L4_2
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L7_2 = L9_2
  end
  if nil ~= L7_2 then
    L9_2 = FormatClothingItem
    L10_2 = not L8_2
    L11_2 = L7_2
    L12_2 = A0_2
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L7_2 = L9_2
  end
  if L7_2 and A3_2 then
    L7_2.price = 0
  end
  if L7_2 then
    L9_2 = TriggerClientEvent
    L10_2 = "rcore_clothing:receiveSingleItemMetadata"
    L11_2 = L4_2
    L12_2 = L7_2
    L9_2(L10_2, L11_2, L12_2)
  else
    L9_2 = TriggerClientEvent
    L10_2 = "rcore_clothing:receiveSingleItemMetadata"
    L11_2 = L4_2
    L12_2 = {}
    L12_2.not_found = A1_2
    L9_2(L10_2, L11_2, L12_2)
  end
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:setOutfitAsCurrent"
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = source
  L2_2 = GetPlayerFwIdentifier
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = GetPlayerPed
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetEntityModel
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = DbGetCurrentOutfit
  L6_2 = L2_2
  L5_2 = L5_2(L6_2)
  L6_2 = #L5_2
  if L6_2 > 0 then
    L6_2 = DbSaveCurrentOutfit
    L7_2 = L2_2
    L8_2 = L4_2
    L9_2 = A0_2
    L6_2(L7_2, L8_2, L9_2)
  else
    L6_2 = DbCreateCurrentOutfit
    L7_2 = L2_2
    L8_2 = L4_2
    L9_2 = A0_2
    L6_2(L7_2, L8_2, L9_2)
  end
end
L1_1(L2_1, L3_1)
L1_1 = RegisterCommand
L2_1 = Config
L2_1 = L2_1.Commands
L2_1 = L2_1.Skin
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2
  L3_2 = A1_2[1]
  if L3_2 then
    L3_2 = tonumber
    L4_2 = A1_2[1]
    L3_2 = L3_2(L4_2)
    if L3_2 and L3_2 > 0 then
      L4_2 = GetPlayerName
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      if L4_2 then
        L2_2 = L3_2
      else
        L4_2 = SendNotification
        L5_2 = A0_2
        L6_2 = "Usage: "
        L7_2 = Config
        L7_2 = L7_2.Commands
        L7_2 = L7_2.Skin
        L8_2 = " [serverId]"
        L6_2 = L6_2 .. L7_2 .. L8_2
        L4_2(L5_2, L6_2)
      end
    else
      L4_2 = SendNotification
      L5_2 = A0_2
      L6_2 = "Usage: "
      L7_2 = Config
      L7_2 = L7_2.Commands
      L7_2 = L7_2.Skin
      L8_2 = " [serverId]"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L4_2(L5_2, L6_2)
    end
  end
  L3_2 = TriggerClientEvent
  L4_2 = "rcore_clothing:openSkinMenu"
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
end
L4_1 = true
L1_1(L2_1, L3_1, L4_1)
L1_1 = AddEventHandler
L2_1 = "onResourceStop"
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = pairs
  L2_2 = L0_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ResetPlayerBucket
    L8_2 = L5_2
    L7_2(L8_2)
  end
end
L1_1(L2_1, L3_1)
