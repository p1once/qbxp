local L0_1, L1_1, L2_1, L3_1, L4_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = Config
  L2_2 = L2_2.UseFrameworkNotify
  if L2_2 then
    L2_2 = Config
    L2_2 = L2_2.Framework
    if 1 ~= L2_2 then
      L2_2 = Config
      L2_2 = L2_2.Framework
      if 2 ~= L2_2 then
        goto lbl_23
      end
    end
    L2_2 = ShowNotification
    L3_2 = A0_2
    if A1_2 then
      L4_2 = "error"
      if L4_2 then
        goto lbl_21
      end
    end
    L4_2 = nil
    ::lbl_21::
    L2_2(L3_2, L4_2)
  ::lbl_23::
  else
    L2_2 = UINotify
    L3_2 = A0_2
    L4_2 = A1_2
    L2_2(L3_2, L4_2)
  end
end
NotifyUser = L0_1
L0_1 = 0
L1_1 = {}
function L2_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L0_1
  L1_2 = L0_1
  L1_2 = L1_2 + 1
  L0_1 = L1_2
  L1_2 = TriggerServerEvent
  L2_2 = "rcore_clothing:requestCurrentOutfit"
  L3_2 = L0_2
  L1_2(L2_2, L3_2)
  while true do
    L1_2 = L1_1
    L1_2 = L1_2[L0_2]
    if nil ~= L1_2 then
      break
    end
    L1_2 = Wait
    L2_2 = 0
    L1_2(L2_2)
  end
  L1_2 = L1_1
  L1_2 = L1_2[L0_2]
  L2_2 = L1_1
  L2_2[L0_2] = nil
  L2_2 = L1_2.outfit
  if not L2_2 then
    L2_2 = L1_2.skin
  end
  L1_2.skin = L2_2
  return L1_2
end
GetCurrentOutfit = L2_1
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:responseCurrentOutfit"
function L4_1(A0_2, A1_2)
  local L2_2
  L2_2 = L1_1
  L2_2[A0_2] = A1_2
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:internal:itemPurchased"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ResolveItemToClothingOrPropItem
    L9_2 = PlayerPedId
    L9_2 = L9_2()
    L10_2 = L7_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = TriggerEvent
    L10_2 = "rcore_clothing:onItemPurchase"
    L11_2 = L8_2.componentId
    L12_2 = L8_2.drawableId
    L13_2 = L8_2.textureId
    L14_2 = L7_2.label
    L15_2 = {}
    L16_2 = L7_2.name_hash
    L15_2.name_hash = L16_2
    L16_2 = L7_2.arms
    L15_2.arms = L16_2
    L16_2 = L8_2.component_id
    if L16_2 then
      L16_2 = L8_2.component_id
      L16_2 = L16_2 >= 100
    end
    L15_2.isProp = L16_2
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  end
  L2_2 = pairs
  L3_2 = A1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ResolveItemToClothingOrPropItem
    L9_2 = PlayerPedId
    L9_2 = L9_2()
    L10_2 = {}
    L10_2.name_hash = L7_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = TriggerEvent
    L10_2 = "rcore_clothing:onItemPurchase"
    L11_2 = L8_2.componentId
    L12_2 = L8_2.drawableId
    L13_2 = L8_2.textureId
    L14_2 = L7_2.label
    L15_2 = {}
    L15_2.name_hash = L7_2
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:clearPed"
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = GetGamePool
  L1_2 = "CObject"
  L0_2 = L0_2(L1_2)
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L2_2 = 1
  L3_2 = #L0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = IsEntityAttachedToEntity
    L7_2 = L0_2[L5_2]
    L8_2 = L1_2
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = DeleteEntity
      L7_2 = L0_2[L5_2]
      L6_2(L7_2)
    end
  end
  L2_2 = ShowNotification
  L3_2 = _U
  L4_2 = "clear_ped"
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L3_2(L4_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:openShop"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = string
  L2_2 = L2_2.len
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if 0 == L2_2 then
    L2_2 = print
    L3_2 = "rcore_clothing:openShop: shopType can't be empty!"
    L2_2(L3_2)
    return
  end
  L2_2 = RequestOpenClothingShopUI
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:openJobChangingRoom"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = string
  L2_2 = L2_2.len
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if 0 == L2_2 then
    L2_2 = print
    L3_2 = "rcore_clothing:openJobChangingRoom: job can't be empty!"
    L2_2(L3_2)
    return
  end
  L2_2 = "job_"
  L3_2 = A0_2
  L2_2 = L2_2 .. L3_2
  if not A1_2 then
    L3_2 = {}
    A1_2 = L3_2
  end
  L3_2 = A1_2.modifiers
  if not L3_2 then
    L3_2 = {}
    A1_2.modifiers = L3_2
  end
  L3_2 = A1_2.modifiers
  L4_2 = SHOP_MODIFIERS
  L4_2 = L4_2.IS_EVERYTHING_FREE
  L3_2[L4_2] = true
  L3_2 = A1_2.modifiers
  L4_2 = SHOP_MODIFIERS
  L4_2 = L4_2.JOB_CHANGING_ROOM
  L3_2[L4_2] = true
  L3_2 = Config
  L4_2 = "JobChangingRoomActsAsPersonalChangingRoom"
  L3_2 = L3_2[L4_2]
  if L3_2 then
    L3_2 = A1_2.modifiers
    L4_2 = SHOP_MODIFIERS
    L4_2 = L4_2.CHANGING_ROOM
    L3_2[L4_2] = true
  end
  L3_2 = A1_2.structure
  if not L3_2 then
    L3_2 = SHOP_CONFIG_ALIAS
    L3_2 = L3_2.CLOTHING
    L3_2 = L3_2.structure
    A1_2.structure = L3_2
  end
  L3_2 = RequestOpenClothingShopUI
  L4_2 = L2_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
end
L2_1(L3_1, L4_1)
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = GetCurrentOutfit
  L0_2 = L0_2()
  if L0_2 then
    L1_2 = L0_2.skin
    if L1_2 then
      L1_2 = L0_2.skin
      L1_2 = L1_2.components
      if L1_2 then
        goto lbl_13
      end
    end
  end
  do return end
  ::lbl_13::
  L1_2 = L0_2.skin
  L1_2 = L1_2.components
  L1_2 = L1_2["11"]
  if not L1_2 then
    return
  end
  L2_2 = GetEntityModel
  L3_2 = PlayerPedId
  L3_2, L4_2, L5_2, L6_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = TriggerServerEvent
  L4_2 = "rcore_clothing:requestRecommendedArmsByHash"
  L5_2 = L1_2
  L6_2 = L2_2
  L3_2(L4_2, L5_2, L6_2)
end
FixArmsForCurrentTop = L2_1
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:setRecommendedArmsByHash"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  if A0_2 then
    L1_2 = A0_2[1]
    if L1_2 then
      goto lbl_7
    end
  end
  do return end
  ::lbl_7::
  L1_2 = A0_2[1]
  L1_2 = L1_2.recommended_arms
  if not L1_2 then
    return
  end
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = UsableHashToData
  L4_2 = L2_2
  L5_2 = L1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = SetPedComponentVariation
  L5_2 = L2_2
  L6_2 = 3
  L7_2 = L3_2.drawableId
  L8_2 = L3_2.textureId
  L9_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = TriggerEvent
  L5_2 = "rcore_clothing:saveCurrentSkin"
  L4_2(L5_2)
end
L2_1(L3_1, L4_1)
