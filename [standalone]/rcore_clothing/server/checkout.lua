local L0_1, L1_1, L2_1, L3_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = 1
  L2_2 = Config
  L2_2 = L2_2.ClothingShops
  L2_2 = #L2_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = Config
    L5_2 = L5_2.ClothingShops
    L5_2 = L5_2[L4_2]
    L6_2 = L5_2.pos
    L6_2 = L6_2.xyz
    L6_2 = A0_2 - L6_2
    L6_2 = #L6_2
    L7_2 = L5_2.config
    if L7_2 then
      L7_2 = L5_2.config
      L7_2 = L7_2.modifiers
      if L7_2 then
        L7_2 = L5_2.config
        L7_2 = L7_2.modifiers
        L7_2 = L7_2.IS_EVERYTHING_FREE
        if L7_2 then
          goto lbl_29
        end
      end
    end
    L7_2 = Config
    L7_2 = L7_2.EverythingEverywhereIsFree
    ::lbl_29::
    if L6_2 < 10.0 then
      L8_2 = not L7_2
      return L8_2
    end
  end
  L1_2 = false
  return L1_2
end
IsNearPaidShop = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = pairs
  L3_2 = A1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "string" == L8_2 then
      L8_2 = string
      L8_2 = L8_2.sub
      L9_2 = L7_2
      L10_2 = 1
      L11_2 = 1
      L8_2 = L8_2(L9_2, L10_2, L11_2)
      if "~" == L8_2 then
        L9_2 = string
        L9_2 = L9_2.sub
        L10_2 = L7_2
        L11_2 = 2
        L9_2 = L9_2(L10_2, L11_2)
        L10_2 = CheckoutSimpleResolveClothingItemToData
        L11_2 = L9_2
        L10_2 = L10_2(L11_2)
        L10_2.price = 0
        L10_2.label = "Clothing item"
        L11_2 = table
        L11_2 = L11_2.insert
        L12_2 = A0_2
        L13_2 = L10_2
        L11_2(L12_2, L13_2)
      end
    end
  end
  return A0_2
end
ResolveFreemodeItems = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "number" == L8_2 then
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L1_2
      L10_2 = L7_2
      L8_2(L9_2, L10_2)
    else
      L8_2 = string
      L8_2 = L8_2.sub
      L9_2 = L7_2
      L10_2 = 1
      L11_2 = 1
      L8_2 = L8_2(L9_2, L10_2, L11_2)
      if "~" ~= L8_2 then
        L9_2 = table
        L9_2 = L9_2.insert
        L10_2 = L1_2
        L11_2 = L7_2
        L9_2(L10_2, L11_2)
      end
    end
  end
  return L1_2
end
FilterFreemodeItems = L0_1
L0_1 = RegisterNetEvent
L1_1 = "rcore_clothing:attemptCheckout"
function L2_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L6_2 = source
  L7_2 = GetPlayerPed
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  L8_2 = GetEntityModel
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  L9_2 = DbGetItemsById
  L10_2 = FilterFreemodeItems
  L11_2 = A3_2
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L10_2(L11_2)
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L10_2 = GetPlayerFwIdentifier
  L11_2 = L6_2
  L10_2 = L10_2(L11_2)
  L11_2 = A5_2 or L11_2
  if A5_2 then
    L11_2 = A5_2.modifiers
    if L11_2 then
      L11_2 = A5_2.modifiers
      L12_2 = SHOP_MODIFIERS
      L12_2 = L12_2.CHANGING_ROOM
      L11_2 = L11_2[L12_2]
    end
  end
  L12_2 = A5_2 or L12_2
  if A5_2 then
    L12_2 = A5_2.modifiers
    if L12_2 then
      L12_2 = A5_2.modifiers
      L13_2 = SHOP_MODIFIERS
      L13_2 = L13_2.IS_EVERYTHING_FREE
      L12_2 = L12_2[L13_2]
    end
  end
  L13_2 = {}
  L14_2 = ResolveFreemodeItems
  L15_2 = L9_2
  L16_2 = A3_2
  L14_2 = L14_2(L15_2, L16_2)
  L9_2 = L14_2
  L14_2 = 0
  if L12_2 or L11_2 then
    L15_2 = IsNearPaidShop
    L16_2 = GetEntityCoords
    L17_2 = L7_2
    L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L16_2(L17_2)
    L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    if L15_2 then
      L15_2 = print
      L16_2 = "ERROR: Unable to make changing room free as player is near paid shop"
      L15_2(L16_2)
    else
      L15_2 = 1
      L16_2 = #L9_2
      L17_2 = 1
      for L18_2 = L15_2, L16_2, L17_2 do
        L19_2 = L9_2[L18_2]
        L19_2.price = 0
      end
    end
  else
    L15_2 = 1
    L16_2 = #L9_2
    L17_2 = 1
    for L18_2 = L15_2, L16_2, L17_2 do
      L19_2 = L9_2[L18_2]
      L19_2 = L19_2.price
      if L19_2 then
        L19_2 = L9_2[L18_2]
        L19_2 = L19_2.custom_price
        if not L19_2 then
          L20_2 = CalculateItemPrice
          L21_2 = L9_2[L18_2]
          L21_2 = L21_2.id
          L22_2 = A1_2
          L23_2 = L9_2[L18_2]
          L23_2 = L23_2.component_id
          L24_2 = L9_2[L18_2]
          L24_2 = L24_2.drawable_id
          L25_2 = L9_2[L18_2]
          L25_2 = L25_2.type
          L26_2 = L9_2[L18_2]
          L26_2 = L26_2.price
          L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
          L19_2 = L20_2
        end
        L14_2 = L14_2 + L19_2
      end
    end
  end
  if L14_2 > 0 then
    L15_2 = FrameworkGetPlayerMoney
    L16_2 = L6_2
    L17_2 = A2_2
    L15_2 = L15_2(L16_2, L17_2)
    if L14_2 > L15_2 then
      L16_2 = TriggerClientEvent
      L17_2 = "rcore_clothing:checkoutResult"
      L18_2 = L6_2
      L19_2 = A0_2
      L20_2 = false
      L21_2 = {}
      L22_2 = L14_2 - L15_2
      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      return
    end
    L16_2 = FrameworkTakePlayerMoney
    L17_2 = L6_2
    L18_2 = A2_2
    L19_2 = L14_2
    L16_2 = L16_2(L17_2, L18_2, L19_2)
    if not L16_2 then
      L16_2 = TriggerClientEvent
      L17_2 = "rcore_clothing:checkoutResult"
      L18_2 = L6_2
      L19_2 = A0_2
      L20_2 = false
      L21_2 = {}
      L22_2 = L14_2
      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      return
    end
  end
  L15_2 = DbGetOrCreateCurrentOutfit
  L16_2 = L10_2
  L17_2 = L8_2
  L15_2 = L15_2(L16_2, L17_2)
  L16_2 = L15_2.components
  if not L16_2 then
    L16_2 = {}
    L15_2.components = L16_2
  end
  L16_2 = L15_2.props
  if not L16_2 then
    L16_2 = {}
    L15_2.props = L16_2
  end
  L16_2 = L15_2.decals
  if not L16_2 then
    L16_2 = {}
    L15_2.decals = L16_2
  end
  L16_2 = 1
  L17_2 = #L9_2
  L18_2 = 1
  for L19_2 = L16_2, L17_2, L18_2 do
    L20_2 = L9_2[L19_2]
    L21_2 = L20_2.name_hash
    L22_2 = L20_2.component_id
    L23_2 = L20_2.id
    if L23_2 then
      L23_2 = L20_2.id
      if L23_2 > 0 then
        L23_2 = DbAddToPurchased
        L24_2 = L10_2
        L25_2 = L20_2.id
        L23_2(L24_2, L25_2)
      end
    end
    if L22_2 < 100 then
      L23_2 = L15_2.components
      L24_2 = tostring
      L25_2 = L22_2
      L24_2 = L24_2(L25_2)
      L23_2[L24_2] = L21_2
      L23_2 = L20_2.decal_name_hash
      if L23_2 then
        L23_2 = L15_2.decals
        L24_2 = tostring
        L25_2 = L22_2
        L24_2 = L24_2(L25_2)
        L25_2 = {}
        L26_2 = L20_2.decal_collection_hash
        L25_2.collection = L26_2
        L26_2 = L20_2.decal_name_hash
        L25_2.name = L26_2
        L23_2[L24_2] = L25_2
      else
        L23_2 = L15_2.decals
        if L23_2 then
          L23_2 = L15_2.decals
          L24_2 = tostring
          L25_2 = L22_2
          L24_2 = L24_2(L25_2)
          L23_2 = L23_2[L24_2]
          if L23_2 then
            L23_2 = L15_2.decals
            L24_2 = tostring
            L25_2 = L22_2
            L24_2 = L24_2(L25_2)
            L23_2[L24_2] = nil
          end
        end
      end
    else
      L22_2 = L22_2 - 100
      L23_2 = L20_2.drawable_id
      if L23_2 < 0 then
        L23_2 = L15_2.props
        L24_2 = tostring
        L25_2 = L22_2
        L24_2 = L24_2(L25_2)
        L23_2[L24_2] = nil
      else
        L23_2 = L15_2.props
        L24_2 = tostring
        L25_2 = L22_2
        L24_2 = L24_2(L25_2)
        L23_2[L24_2] = L21_2
      end
    end
  end
  L16_2 = A4_2.arms
  if L16_2 then
    L16_2 = L15_2.components
    L17_2 = tostring
    L18_2 = 3
    L17_2 = L17_2(L18_2)
    L18_2 = A4_2.arms
    L16_2[L17_2] = L18_2
    L16_2 = table
    L16_2 = L16_2.insert
    L17_2 = L13_2
    L18_2 = A4_2.arms
    L16_2(L17_2, L18_2)
  end
  L16_2 = A4_2.shoplessComponent
  if L16_2 then
    L16_2 = pairs
    L17_2 = A4_2.shoplessComponent
    L16_2, L17_2, L18_2, L19_2 = L16_2(L17_2)
    for L20_2, L21_2 in L16_2, L17_2, L18_2, L19_2 do
      L22_2 = L15_2.components
      L23_2 = tostring
      L24_2 = L20_2
      L23_2 = L23_2(L24_2)
      L22_2[L23_2] = L21_2
      L22_2 = table
      L22_2 = L22_2.insert
      L23_2 = L13_2
      L24_2 = L21_2
      L22_2(L23_2, L24_2)
      if 8 == L20_2 or 11 == L20_2 then
        L22_2 = L15_2.decals
        if L22_2 then
          L22_2 = L15_2.decals
          L23_2 = tostring
          L24_2 = L20_2
          L23_2 = L23_2(L24_2)
          L22_2 = L22_2[L23_2]
          if L22_2 then
            L22_2 = L15_2.decals
            L23_2 = tostring
            L24_2 = L20_2
            L23_2 = L23_2(L24_2)
            L22_2[L23_2] = nil
          end
        end
      end
    end
  end
  L16_2 = A4_2.shoplessProp
  if L16_2 then
    L16_2 = pairs
    L17_2 = A4_2.shoplessProp
    L16_2, L17_2, L18_2, L19_2 = L16_2(L17_2)
    for L20_2, L21_2 in L16_2, L17_2, L18_2, L19_2 do
      L22_2 = L15_2.props
      L23_2 = tostring
      L24_2 = L20_2
      L23_2 = L23_2(L24_2)
      L22_2[L23_2] = L21_2
      L22_2 = table
      L22_2 = L22_2.insert
      L23_2 = L13_2
      L24_2 = L21_2
      L22_2(L23_2, L24_2)
    end
  end
  L16_2 = {}
  L17_2 = 1
  L18_2 = #L9_2
  L19_2 = 1
  for L20_2 = L17_2, L18_2, L19_2 do
    L21_2 = nil
    L22_2 = L9_2[L20_2]
    L22_2 = L22_2.component_id
    if 11 == L22_2 then
      L21_2 = A4_2.arms
    end
    L22_2 = table
    L22_2 = L22_2.insert
    L23_2 = L16_2
    L24_2 = {}
    L25_2 = L9_2[L20_2]
    L25_2 = L25_2.component_id
    L24_2.component_id = L25_2
    L25_2 = L9_2[L20_2]
    L25_2 = L25_2.name_hash
    L24_2.name_hash = L25_2
    L25_2 = L9_2[L20_2]
    L25_2 = L25_2.decal_collection_hash
    L24_2.decal_collection_hash = L25_2
    L25_2 = L9_2[L20_2]
    L25_2 = L25_2.decal_name_hash
    L24_2.decal_name_hash = L25_2
    L25_2 = L9_2[L20_2]
    L25_2 = L25_2.drawable_id
    L24_2.drawable_id = L25_2
    L25_2 = L9_2[L20_2]
    L25_2 = L25_2.texture_id
    L24_2.texture_id = L25_2
    L25_2 = L9_2[L20_2]
    L25_2 = L25_2.label
    L24_2.label = L25_2
    L24_2.arms = L21_2
    L22_2(L23_2, L24_2)
  end
  L17_2 = DbSaveCurrentOutfit
  L18_2 = L10_2
  L19_2 = L8_2
  L20_2 = L15_2
  L17_2(L18_2, L19_2, L20_2)
  L17_2 = TriggerClientEvent
  L18_2 = "rcore_clothing:checkoutResult"
  L19_2 = L6_2
  L20_2 = A0_2
  L21_2 = true
  L22_2 = L16_2
  L23_2 = nil
  L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  L17_2 = TriggerClientEvent
  L18_2 = "rcore_clothing:internal:itemPurchased"
  L19_2 = L6_2
  L20_2 = L16_2
  L21_2 = L13_2
  L17_2(L18_2, L19_2, L20_2, L21_2)
end
L0_1(L1_1, L2_1)
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = FrameworkGetPlayerMoney
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = Config
  L4_2 = L4_2.CharFeaturesPrices
  L4_2 = L4_2[A2_2]
  if not L4_2 then
    L4_2 = 0
  end
  if 0 == L4_2 then
    L5_2 = true
    return L5_2
  end
  if L3_2 < L4_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = FrameworkTakePlayerMoney
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = L4_2
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  if not L5_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = true
  return L5_2
end
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:attemptHeadMod"
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L4_2 = source
  L5_2 = GetPlayerPed
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = GetEntityModel
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetPlayerFwIdentifier
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L8_2 = DbGetOrCreateCurrentOutfit
  L9_2 = L7_2
  L10_2 = L6_2
  L8_2 = L8_2(L9_2, L10_2)
  if A3_2 then
    L9_2 = A1_2
    if "headOverlay" == A1_2 then
      L10_2 = "headOverlay_"
      L11_2 = A2_2.overlayId
      L10_2 = L10_2 .. L11_2
      L9_2 = L10_2
    end
    L10_2 = L0_1
    L11_2 = L4_2
    L12_2 = A3_2
    L13_2 = L9_2
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    if not L10_2 then
      L10_2 = TriggerClientEvent
      L11_2 = "rcore_clothing:headModResult"
      L12_2 = L4_2
      L13_2 = A0_2
      L14_2 = false
      L10_2(L11_2, L12_2, L13_2, L14_2)
      return
    end
  end
  L9_2 = SHOP_STRUCTURE
  L9_2 = L9_2.CHAR_NONFREEMODE_HEAD
  if A1_2 == L9_2 then
    L9_2 = L8_2.components
    if not L9_2 then
      L9_2 = {}
      L8_2.components = L9_2
    end
    L9_2 = L8_2.components
    L10_2 = A2_2.values
    L9_2["0"] = L10_2
  end
  L9_2 = SHOP_STRUCTURE
  L9_2 = L9_2.CHAR_HEADBLEND
  if A1_2 == L9_2 then
    L8_2.headblend = A2_2
  end
  if "headOverlay" == A1_2 then
    L9_2 = L8_2.headOverlay
    if not L9_2 then
      L9_2 = {}
      L8_2.headOverlay = L9_2
    end
    L9_2 = L8_2.headOverlay
    L10_2 = tostring
    L11_2 = A2_2.overlayId
    L10_2 = L10_2(L11_2)
    L11_2 = {}
    L12_2 = A2_2.id
    L11_2.id = L12_2
    L12_2 = A2_2.opacity
    L11_2.opacity = L12_2
    L12_2 = A2_2.color1
    L11_2.color1 = L12_2
    L12_2 = A2_2.color2
    L11_2.color2 = L12_2
    L9_2[L10_2] = L11_2
  end
  L9_2 = SHOP_STRUCTURE
  L9_2 = L9_2.HAIR_HAIR
  if A1_2 == L9_2 then
    L9_2 = {}
    L10_2 = A2_2.id
    L9_2.id = L10_2
    L10_2 = A2_2.color1
    L9_2.color1 = L10_2
    L10_2 = A2_2.color2
    L9_2.color2 = L10_2
    L8_2.hair = L9_2
  end
  L9_2 = SHOP_STRUCTURE
  L9_2 = L9_2.CHAR_EYE_COLOR
  if A1_2 == L9_2 then
    L9_2 = A2_2.id
    L8_2.eyeColor = L9_2
  end
  L9_2 = SHOP_STRUCTURE
  L9_2 = L9_2.CHAR_FACE_FEATURES
  if A1_2 == L9_2 then
    L9_2 = A2_2.values
    L8_2.faceFeatures = L9_2
  end
  L9_2 = DbSaveCurrentOutfit
  L10_2 = L7_2
  L11_2 = L6_2
  L12_2 = L8_2
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = TriggerClientEvent
  L10_2 = "rcore_clothing:headModResult"
  L11_2 = L4_2
  L12_2 = A0_2
  L13_2 = true
  L9_2(L10_2, L11_2, L12_2, L13_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:setPedModel"
function L3_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L5_2 = source
  L6_2 = GetPlayerPed
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetEntityModel
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  L8_2 = GetPlayerFwIdentifier
  L9_2 = L5_2
  L8_2 = L8_2(L9_2)
  if A4_2 then
    L9_2 = L0_1
    L10_2 = L5_2
    L11_2 = A4_2
    L12_2 = SHOP_STRUCTURE
    L12_2 = L12_2.CHAR_PED_SELECT
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    if not L9_2 then
      L9_2 = TriggerClientEvent
      L10_2 = "rcore_clothing:setPedModelResult"
      L11_2 = L5_2
      L12_2 = A0_2
      L13_2 = false
      L9_2(L10_2, L11_2, L12_2, L13_2)
      return
    end
  end
  L9_2 = {}
  L9_2.components = A2_2
  L9_2.headblend = A3_2
  L10_2 = DbChangePedModelOutfit
  L11_2 = L8_2
  L12_2 = A1_2
  L13_2 = L9_2
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = TriggerClientEvent
  L11_2 = "rcore_clothing:setHairData"
  L12_2 = L5_2
  L13_2 = DbGetHair
  L14_2 = L7_2
  L13_2, L14_2 = L13_2(L14_2)
  L10_2(L11_2, L12_2, L13_2, L14_2)
  L10_2 = TriggerClientEvent
  L11_2 = "rcore_clothing:setPedModelResult"
  L12_2 = L5_2
  L13_2 = A0_2
  L14_2 = true
  L10_2(L11_2, L12_2, L13_2, L14_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:selectOutfit"
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
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
  L5_2 = DbGetOutfitById
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  if L5_2 then
    L6_2 = DbGetOrCreateCurrentOutfit
    L7_2 = L4_2
    L8_2 = L3_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = L6_2.components
    if not L7_2 then
      L7_2 = {}
      L6_2.components = L7_2
    end
    L7_2 = L6_2.props
    if not L7_2 then
      L7_2 = {}
      L6_2.props = L7_2
    end
    L7_2 = json
    L7_2 = L7_2.decode
    L8_2 = L5_2.outfit
    L7_2 = L7_2(L8_2)
    L5_2 = L7_2
    L7_2 = pairs
    L8_2 = L5_2.components
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = L6_2.components
      L14_2 = tostring
      L15_2 = L11_2
      L14_2 = L14_2(L15_2)
      L13_2[L14_2] = L12_2
    end
    L7_2 = pairs
    L8_2 = L5_2.props
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = L6_2.props
      L14_2 = tostring
      L15_2 = L11_2
      L14_2 = L14_2(L15_2)
      L13_2[L14_2] = L12_2
    end
    L7_2 = DbSaveCurrentOutfit
    L8_2 = L4_2
    L9_2 = L3_2
    L10_2 = L6_2
    L7_2(L8_2, L9_2, L10_2)
  else
    L6_2 = print
    L7_2 = "Error: outfit not found"
    L8_2 = A0_2
    L6_2(L7_2, L8_2)
  end
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:removePersonalOutfit"
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = source
  L2_2 = GetPlayerFwIdentifier
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = DbRemovePersonalOutfit
  L4_2 = L2_2
  L5_2 = A0_2
  L3_2(L4_2, L5_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:removeShopOutfit"
function L3_1(A0_2)
  local L1_2, L2_2
  L1_2 = DbRemoveShopOutfit
  L2_2 = A0_2
  L1_2(L2_2)
end
L1_1(L2_1, L3_1)
L1_1 = RegisterNetEvent
L2_1 = "rcore_clothing:buyOutfit"
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
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
  L5_2 = DbGetOutfitById
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  if L5_2 then
    L6_2 = L5_2.price
    if L6_2 then
    end
    L6_2 = DbSavePersonalOutfit
    L7_2 = L4_2
    L8_2 = L3_2
    L9_2 = L5_2.name
    L10_2 = json
    L10_2 = L10_2.decode
    L11_2 = L5_2.outfit
    L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L10_2(L11_2)
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L6_2 = DbGetOrCreateCurrentOutfit
    L7_2 = L4_2
    L8_2 = L3_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = L6_2.components
    if not L7_2 then
      L7_2 = {}
      L6_2.components = L7_2
    end
    L7_2 = L6_2.props
    if not L7_2 then
      L7_2 = {}
      L6_2.props = L7_2
    end
    L7_2 = json
    L7_2 = L7_2.decode
    L8_2 = L5_2.outfit
    L7_2 = L7_2(L8_2)
    L5_2 = L7_2
    L7_2 = pairs
    L8_2 = L5_2.components
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = L6_2.components
      L14_2 = tostring
      L15_2 = L11_2
      L14_2 = L14_2(L15_2)
      L13_2[L14_2] = L12_2
    end
    L7_2 = pairs
    L8_2 = L5_2.props
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = L6_2.props
      L14_2 = tostring
      L15_2 = L11_2
      L14_2 = L14_2(L15_2)
      L13_2[L14_2] = L12_2
    end
    L7_2 = DbSaveCurrentOutfit
    L8_2 = L4_2
    L9_2 = L3_2
    L10_2 = L6_2
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = TriggerClientEvent
    L8_2 = "rcore_clothing:outfitBought"
    L9_2 = L1_2
    L10_2 = L5_2
    L7_2(L8_2, L9_2, L10_2)
  else
    L6_2 = print
    L7_2 = "Error: outfit not found"
    L8_2 = A0_2
    L6_2(L7_2, L8_2)
  end
end
L1_1(L2_1, L3_1)
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if nil == A1_2 then
    A1_2 = "%s"
  end
  L2_2 = {}
  L3_2 = string
  L3_2 = L3_2.gmatch
  L4_2 = A0_2
  L5_2 = "([^"
  L6_2 = A1_2
  L7_2 = "]+)"
  L5_2 = L5_2 .. L6_2 .. L7_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
  for L7_2 in L3_2, L4_2, L5_2, L6_2 do
    L8_2 = table
    L8_2 = L8_2.insert
    L9_2 = L2_2
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
  end
  return L2_2
end
mysplit = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = string
  L1_2 = L1_2.sub
  L2_2 = A0_2
  L3_2 = 1
  L4_2 = 1
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "m" == L1_2 then
    L2_2 = tostring
    L3_2 = tonumber
    L4_2 = string
    L4_2 = L4_2.sub
    L5_2 = A0_2
    L6_2 = 2
    L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L3_2 = -L3_2
    return L2_2(L3_2)
  end
  return A0_2
end
handleSmartMinus = L1_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if nil == A1_2 then
    A1_2 = "%s"
  end
  L2_2 = {}
  L3_2 = string
  L3_2 = L3_2.gmatch
  L4_2 = A0_2
  L5_2 = "([^"
  L6_2 = A1_2
  L7_2 = "]+)"
  L5_2 = L5_2 .. L6_2 .. L7_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
  for L7_2 in L3_2, L4_2, L5_2, L6_2 do
    L8_2 = table
    L8_2 = L8_2.insert
    L9_2 = L2_2
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
  end
  L3_2 = {}
  L4_2 = #L2_2
  L4_2 = L4_2 - 3
  L4_2 = L2_2[L4_2]
  L5_2 = #L2_2
  L5_2 = L5_2 - 2
  L5_2 = L2_2[L5_2]
  L6_2 = handleSmartMinus
  L7_2 = #L2_2
  L7_2 = L7_2 - 1
  L7_2 = L2_2[L7_2]
  L6_2 = L6_2(L7_2)
  L7_2 = #L2_2
  L7_2 = L2_2[L7_2]
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  return L3_2
end
clothingSplit = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = {}
  L2_2 = clothingSplit
  L3_2 = A0_2
  L4_2 = "--"
  L2_2 = L2_2(L3_2, L4_2)
  L1_2.name_hash = A0_2
  L3_2 = tonumber
  L4_2 = L2_2[2]
  L3_2 = L3_2(L4_2)
  L1_2.component_id = L3_2
  L3_2 = tonumber
  L4_2 = L2_2[3]
  L3_2 = L3_2(L4_2)
  L1_2.drawable_id = L3_2
  L3_2 = tonumber
  L4_2 = L2_2[4]
  L3_2 = L3_2(L4_2)
  L1_2.texture_id = L3_2
  L1_2.palette = 2
  return L1_2
end
CheckoutSimpleResolveClothingItemToData = L1_1
