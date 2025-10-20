local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1
L0_1 = nil
L1_1 = nil
L2_1 = false
L3_1 = false
L4_1 = false
L5_1 = false
L6_1 = false
L7_1 = false
L8_1 = nil
function L9_1(A0_2)
  local L1_2
  L8_1 = A0_2
end
SetCurrentShopConfig = L9_1
function L9_1()
  local L0_2, L1_2
  L0_2 = L8_1
  return L0_2
end
GetCurrentShopConfig = L9_1
function L9_1()
  local L0_2, L1_2, L2_2
  L0_2 = GetCurrentShopConfig
  L0_2 = L0_2()
  L1_2 = L0_2 or L1_2
  if L0_2 then
    L1_2 = L0_2.modifiers
    if L1_2 then
      L1_2 = L0_2.modifiers
      L2_2 = SHOP_MODIFIERS
      L2_2 = L2_2.HAS_EVERYTHING
      L1_2 = L1_2[L2_2]
    end
  end
  return L1_2
end
HasCurrentShopGotEverything = L9_1
function L9_1()
  local L0_2, L1_2, L2_2
  L0_2 = GetCurrentShopConfig
  L0_2 = L0_2()
  L1_2 = L0_2 or L1_2
  if L0_2 then
    L1_2 = L0_2.modifiers
    if L1_2 then
      L1_2 = L0_2.modifiers
      L2_2 = SHOP_MODIFIERS
      L2_2 = L2_2.ID_MODE_HAS_EVERYTHING
      L1_2 = L1_2[L2_2]
    end
  end
  return L1_2
end
HasCurrentShopGotEverythingIdMode = L9_1
function L9_1()
  local L0_2, L1_2, L2_2
  L0_2 = GetCurrentShopConfig
  L0_2 = L0_2()
  L1_2 = L0_2 or L1_2
  if L0_2 then
    L1_2 = L0_2.modifiers
    if L1_2 then
      L1_2 = L0_2.modifiers
      L2_2 = SHOP_MODIFIERS
      L2_2 = L2_2.IS_EVERYTHING_FREE
      L1_2 = L1_2[L2_2]
    end
  end
  return L1_2
end
HasCurrentShopEverythingFree = L9_1
function L9_1()
  local L0_2, L1_2
  L0_2 = nil
  L8_1 = L0_2
end
ClearCurrentShopConfig = L9_1
function L9_1()
  local L0_2, L1_2
  L0_2 = L0_1
  return L0_2
end
GetInitialPedSetup = L9_1
function L9_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = IsModelFreemode
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    return
  end
  L1_2 = {}
  L2_2 = 1885233650
  L3_2 = {}
  L3_2.maleModel = 0
  L3_2.femaleModel = 45
  L3_2.maleTone = 0
  L3_2.femaleTone = 0
  L3_2.modelBlend = 0.0
  L3_2.toneBlend = 0.0
  L1_2[L2_2] = L3_2
  L2_2 = -1667301416
  L3_2 = {}
  L3_2.maleModel = 0
  L3_2.femaleModel = 45
  L3_2.maleTone = 0
  L3_2.femaleTone = 0
  L3_2.modelBlend = 1.0
  L3_2.toneBlend = 0.0
  L1_2[L2_2] = L3_2
  L2_2 = Config
  L2_2 = L2_2.DefaultHeadblend
  if L2_2 then
    L2_2 = Config
    L2_2 = L2_2.DefaultHeadblend
    L2_2 = L2_2[A0_2]
  end
  if not L2_2 then
    L2_2 = L1_2[A0_2]
  end
  return L2_2
end
GetDefaultHeadblend = L9_1
function L9_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = IsModelFreemode
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    return
  end
  L2_2 = GetDefaultHeadblend
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L3_2 = SetPedHeadBlendData
    L4_2 = A1_2
    L5_2 = L2_2.maleModel
    L6_2 = L2_2.femaleModel
    L7_2 = 0
    L8_2 = L2_2.maleTone
    L9_2 = L2_2.femaleTone
    L10_2 = 0
    L11_2 = L2_2.modelBlend
    L12_2 = L2_2.toneBlend
    L13_2 = 0.0
    L14_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  end
end
ApplyDefaultHeadblend = L9_1
function L9_1()
  local L0_2, L1_2
  L0_2 = CreateThread
  function L1_2()
    local L0_3, L1_3
    while true do
      L0_3 = L8_1
      if not L0_3 then
        break
      end
      L0_3 = PlayerPedId
      L0_3 = L0_3()
      L1_1 = L0_3
      L0_3 = Wait
      L1_3 = 500
      L0_3(L1_3)
    end
  end
  L0_2(L1_2)
end
SpawnPedRefreshWorker = L9_1
function L9_1(A0_2)
  local L1_2, L2_2
  L1_2 = IsHeadShrinked
  L1_2 = L1_2()
  if L1_2 then
    L1_2 = GetPreShrinkHeadblend
    return L1_2()
  end
  L1_2 = GetFormattedPedHeadblendData
  L2_2 = A0_2
  return L1_2(L2_2)
end
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = GetPedComponentData
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = GetUsableHash
  L3_2 = 2
  L4_2 = L1_2[2]
  L4_2 = L4_2[1]
  L5_2 = L1_2[2]
  L5_2 = L5_2[2]
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = {}
  L4_2 = L9_1
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L3_2.headblend = L4_2
  L4_2 = GetPedPropData
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L3_2.props = L4_2
  L3_2.components = L1_2
  L3_2.hair = L2_2
  L4_2 = GetHairColorData
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L3_2.hairColor = L4_2
  L4_2 = GetPedFaceFeatures
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L3_2.face = L4_2
  L4_2 = GetPedEyeColor
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L3_2.eyeColor = L4_2
  L4_2 = GetPedHeadOverlays
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L3_2.headOverlay = L4_2
  L4_2 = GetEntityModel
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L3_2.pedModel = L4_2
  L4_2 = GetAppliedDecalByComponentId
  L5_2 = 8
  L4_2 = L4_2(L5_2)
  L3_2.decal8 = L4_2
  L4_2 = GetAppliedDecalByComponentId
  L5_2 = 11
  L4_2 = L4_2(L5_2)
  L3_2.decal11 = L4_2
  return L3_2
end
GetCurrentPedData = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = GetShopPed
  L0_2 = L0_2()
  L1_2 = GetCurrentPedData
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = SendReactMessage
  L3_2 = "setCurrentPedData"
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
SendCurrentPedDataNUI = L10_1
function L10_1(A0_2)
  local L1_2, L2_2
  L1_1 = A0_2
  L1_2 = SpawnPedRefreshWorker
  L1_2()
  L1_2 = GetCurrentPedData
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L0_1 = L1_2
end
ShopInit = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L1_1
  return L0_2
end
GetShopPed = L10_1
function L10_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L6_2 = true
  L2_1 = L6_2
  L6_2 = SetPedHeadBlendData
  L7_2 = L1_1
  L8_2 = A0_2
  L9_2 = A1_2
  L10_2 = 0
  L11_2 = A3_2
  L12_2 = A4_2
  L13_2 = 0
  L14_2 = A2_2
  L15_2 = A5_2
  L16_2 = 0.0
  L17_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
end
ShopHeadblendPreview = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L2_1
  return L0_2
end
ShopHeadblendIsPreviewing = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = IsModelFreemode
  L1_2 = GetEntityModel
  L2_2 = PlayerPedId
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  if not L0_2 then
    return
  end
  L0_2 = false
  L2_1 = L0_2
  L0_2 = SetPedHeadBlendData
  L1_2 = L1_1
  L2_2 = L0_1.headblend
  L2_2 = L2_2[1]
  L3_2 = L0_1.headblend
  L3_2 = L3_2[2]
  L4_2 = L0_1.headblend
  L4_2 = L4_2[3]
  L5_2 = L0_1.headblend
  L5_2 = L5_2[4]
  L6_2 = L0_1.headblend
  L6_2 = L6_2[5]
  L7_2 = L0_1.headblend
  L7_2 = L7_2[6]
  L8_2 = L0_1.headblend
  L8_2 = L8_2[7]
  L9_2 = L0_1.headblend
  L9_2 = L9_2[8]
  L10_2 = L0_1.headblend
  L10_2 = L10_2[9]
  L11_2 = false
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
end
ShopHeadblendReset = L10_1
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = true
  L3_1 = L2_2
  L2_2 = SetPedFaceFeature
  L3_2 = L1_1
  L4_2 = A0_2
  L5_2 = A1_2
  L2_2(L3_2, L4_2, L5_2)
end
ShopFaceFeaturePreview = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L3_1
  return L0_2
end
ShopFaceFeatureIsPreviewing = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = GetShopPed
  L0_2 = L0_2()
  L1_2 = UnshrinkHead
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = false
  L3_1 = L1_2
  L1_2 = pairs
  L2_2 = L0_1.face
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = SetPedFaceFeature
    L8_2 = L1_1
    L9_2 = L5_2
    L10_2 = L6_2
    L7_2(L8_2, L9_2, L10_2)
  end
  L1_2 = EnsureHeadShrink
  L1_2()
end
ShopFaceFeatureReset = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = true
  L4_1 = L1_2
  L1_2 = SetPedEyeColor
  L2_2 = L1_1
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
ShopEyeColorPreview = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L4_1
  return L0_2
end
ShopEyeColorIsPreviewing = L10_1
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = false
  L4_1 = L0_2
  L0_2 = SetPedEyeColor
  L1_2 = L1_1
  L2_2 = L0_1.eyeColor
  L0_2(L1_2, L2_2)
end
ShopEyeColorReset = L10_1
function L10_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = true
  L5_1 = L4_2
  L4_2 = RcoreSetPedComponentVariation
  L5_2 = L1_1
  L6_2 = 2
  L7_2 = A0_2
  L8_2 = A3_2 or L8_2
  if not A3_2 then
    L8_2 = 0
  end
  L9_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = SetPedHairColor
  L5_2 = L1_1
  L6_2 = A1_2
  L7_2 = A2_2
  L4_2(L5_2, L6_2, L7_2)
end
ShopHairPreview = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L5_1
  return L0_2
end
ShopHairIsPreviewing = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = false
  L5_1 = L0_2
  L0_2 = RcoreSetPedComponentVariation
  L1_2 = L1_1
  L2_2 = 2
  L3_2 = L0_1.components
  L3_2 = L3_2[2]
  L3_2 = L3_2[1]
  L4_2 = L0_1.components
  L4_2 = L4_2[2]
  L4_2 = L4_2[2]
  L5_2 = L0_1.components
  L5_2 = L5_2[2]
  L5_2 = L5_2[3]
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = SetPedHairColor
  L1_2 = L1_1
  L2_2 = L0_1.hairColor
  L2_2 = L2_2[1]
  L3_2 = L0_1.hairColor
  L3_2 = L3_2[2]
  L0_2(L1_2, L2_2, L3_2)
end
ShopHairReset = L10_1
function L10_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L6_1 = A0_2
  if -1 == A1_2 then
    A1_2 = 255
  end
  L5_2 = SetPedHeadOverlay
  L6_2 = L1_1
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2 or L9_2
  if not A2_2 then
    L9_2 = 1.0
  end
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = 0
  if 2 == A0_2 or 1 == A0_2 or 10 == A0_2 then
    L5_2 = 1
  elseif 5 == A0_2 or 8 == A0_2 or 4 == A0_2 then
    L5_2 = 2
  end
  if A3_2 then
    L6_2 = SetPedHeadOverlayColor
    L7_2 = L1_1
    L8_2 = A0_2
    L9_2 = L5_2
    L10_2 = A3_2
    L11_2 = A4_2 or L11_2
    if not A4_2 then
      L11_2 = 0
    end
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  end
end
ShopHeadOverlayPreview = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L6_1
  L0_2 = false ~= L0_2
  return L0_2
end
ShopHeadOverlayIsPreviewing = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = L6_1
  if false ~= L0_2 then
    L0_2 = L0_1.headOverlay
    L1_2 = L6_1
    L0_2 = L0_2[L1_2]
    if L0_2 then
      L1_2 = SetPedHeadOverlay
      L2_2 = L1_1
      L3_2 = L6_1
      L4_2 = L0_2[1]
      L5_2 = L0_2[5]
      L1_2(L2_2, L3_2, L4_2, L5_2)
      L1_2 = SetPedHeadOverlayColor
      L2_2 = L1_1
      L3_2 = L6_1
      L4_2 = L0_2[2]
      L5_2 = L0_2[3]
      L6_2 = L0_2[4]
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    end
    L1_2 = false
    L6_1 = L1_2
  end
end
ShopHeadOverlayReset = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = L1_1
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ApplyPedClothingItem
    L9_2 = L1_2
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
    L8_2 = L7_2.component_id
    if 8 == L8_2 then
      L8_2 = L7_2.decal_collection_hash
      if nil ~= L8_2 then
        L8_2 = {}
        L9_2 = L7_2.decal_collection_hash
        L10_2 = L7_2.decal_name_hash
        L8_2[1] = L9_2
        L8_2[2] = L10_2
        L0_1.decal8 = L8_2
      else
        L0_1.decal8 = nil
      end
    else
      L8_2 = L7_2.component_id
      if 11 == L8_2 then
        L8_2 = L7_2.decal_collection_hash
        if nil ~= L8_2 then
          L8_2 = {}
          L9_2 = L7_2.decal_collection_hash
          L10_2 = L7_2.decal_name_hash
          L8_2[1] = L9_2
          L8_2[2] = L10_2
          L0_1.decal11 = L8_2
        else
          L0_1.decal11 = nil
        end
      end
    end
    L8_2 = L7_2.component_id
    if L8_2 >= 100 then
      L8_2 = L7_2.component_id
      L8_2 = L8_2 - 100
      L9_2 = L0_1.props
      L10_2 = GetPedSinglePropData
      L11_2 = L1_2
      L12_2 = L8_2
      L10_2 = L10_2(L11_2, L12_2)
      L9_2[L8_2] = L10_2
    else
      L8_2 = L0_1.components
      L9_2 = L7_2.component_id
      L10_2 = GetPedSingleComponentData
      L11_2 = L1_2
      L12_2 = L7_2.component_id
      L10_2 = L10_2(L11_2, L12_2)
      L8_2[L9_2] = L10_2
    end
  end
end
ShopSetComponentPurchasedByHash = L10_1
function L10_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2
  L5_2 = GetShopPed
  L5_2 = L5_2()
  L6_2 = ApplyPedClothingItem
  L7_2 = L5_2
  L8_2 = {}
  L8_2.name_hash = A1_2
  L8_2.decal_collection_hash = A2_2
  L8_2.decal_name_hash = A3_2
  L9_2 = A4_2
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = L0_1.components
  L7_2 = GetPedSingleComponentData
  L8_2 = L5_2
  L9_2 = A0_2
  L7_2 = L7_2(L8_2, L9_2)
  L6_2[A0_2] = L7_2
  if 8 == A0_2 then
    if nil == A2_2 or 0 == A2_2 then
      L0_1.decal8 = nil
    else
      L6_2 = {}
      L7_2 = A2_2
      L8_2 = A3_2
      L6_2[1] = L7_2
      L6_2[2] = L8_2
      L0_1.decal8 = L6_2
    end
  elseif 11 == A0_2 then
    if nil == A2_2 or 0 == A2_2 then
      L0_1.decal11 = nil
    else
      L6_2 = {}
      L7_2 = A2_2
      L8_2 = A3_2
      L6_2[1] = L7_2
      L6_2[2] = L8_2
      L0_1.decal11 = L6_2
    end
  end
end
ShopSetComponentByHash = L10_1
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = GetShopPed
  L2_2 = L2_2()
  L3_2 = UsablePropHashToData
  L4_2 = L2_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2.drawableId
  if L4_2 < 0 then
    L4_2 = ClearPedProp
    L5_2 = L2_2
    L6_2 = A0_2
    L4_2(L5_2, L6_2)
  else
    L4_2 = SetPedPropIndex
    L5_2 = L2_2
    L6_2 = A0_2
    L7_2 = L3_2.drawableId
    L8_2 = L3_2.textureId
    L9_2 = true
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  end
  L4_2 = L0_1.props
  L5_2 = GetPedSinglePropData
  L6_2 = L2_2
  L7_2 = A0_2
  L5_2 = L5_2(L6_2, L7_2)
  L4_2[A0_2] = L5_2
end
ShopSetPropByHash = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L0_1.components
  L1_2 = GetPedSingleComponentData
  L2_2 = L1_1
  L3_2 = 0
  L1_2 = L1_2(L2_2, L3_2)
  L0_2[0] = L1_2
end
ShopConfirmHead = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = false
  L2_1 = L0_2
  L0_2 = GetFormattedPedHeadblendData
  L1_2 = L1_1
  L0_2 = L0_2(L1_2)
  L0_1.headblend = L0_2
end
ShopConfirmHeadblend = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = false
  L5_1 = L0_2
  L0_2 = L0_1.components
  L1_2 = GetPedSingleComponentData
  L2_2 = L1_1
  L3_2 = 2
  L1_2 = L1_2(L2_2, L3_2)
  L0_2[2] = L1_2
  L0_2 = GetHairColorData
  L1_2 = L1_1
  L0_2 = L0_2(L1_2)
  L0_1.hairColor = L0_2
end
ShopConfirmHair = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = false
  L3_1 = L0_2
  L0_2 = GetPedFaceFeatures
  L1_2 = L1_1
  L0_2 = L0_2(L1_2)
  L0_1.face = L0_2
end
ShopConfirmFaceFeatures = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = false
  L4_1 = L0_2
  L0_2 = GetPedEyeColor
  L1_2 = L1_1
  L0_2 = L0_2(L1_2)
  L0_1.eyeColor = L0_2
end
ShopConfirmEyeColor = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = false
  L6_1 = L0_2
  L0_2 = GetPedHeadOverlays
  L1_2 = L1_1
  L0_2 = L0_2(L1_2)
  L0_1.headOverlay = L0_2
end
ShopConfirmHeadOverlay = L10_1
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = GetShopPed
  L2_2 = L2_2()
  if L2_2 then
    L3_2 = IsPedFreemode
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = ClearAllPedProps
      L4_2 = L2_2
      L3_2(L4_2)
      L3_2 = Config
      L3_2 = L3_2.ResetAllOnOutfitChange
      if L3_2 then
        L3_2 = CustomSetDefaultVariations
        L4_2 = L2_2
        L3_2(L4_2)
      else
        L3_2 = RcoreSetPedComponentVariation
        L4_2 = L2_2
        L5_2 = 1
        L6_2 = 0
        L7_2 = 0
        L8_2 = 2
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
      end
    end
  end
  L3_2 = A0_2.headblend
  if L3_2 then
    L3_2 = ApplyPedClothingOutfit
    L4_2 = L2_2
    L5_2 = A0_2
    L3_2(L4_2, L5_2)
    if A1_2 then
      L3_2 = GetCurrentPedData
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      L0_1 = L3_2
    end
  else
    L3_2 = pairs
    L4_2 = A0_2.components
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = tonumber
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L7_2 = L9_2
      L9_2 = nil
      L10_2 = nil
      L11_2 = A0_2.decals
      if L11_2 then
        L11_2 = A0_2.decals
        L12_2 = tostring
        L13_2 = L7_2
        L12_2 = L12_2(L13_2)
        L11_2 = L11_2[L12_2]
        if L11_2 then
          L11_2 = A0_2.decals
          L12_2 = tostring
          L13_2 = L7_2
          L12_2 = L12_2(L13_2)
          L11_2 = L11_2[L12_2]
          L12_2 = L11_2.collection
          L10_2 = L11_2.name
          L9_2 = L12_2
        end
      end
      if A1_2 then
        L11_2 = ShopSetComponentByHash
        L12_2 = L7_2
        L13_2 = L8_2
        L14_2 = L9_2
        L15_2 = L10_2
        L16_2 = true
        L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
      else
        L11_2 = ApplyPedClothingItem
        L12_2 = L2_2
        L13_2 = {}
        L13_2.name_hash = L8_2
        L13_2.decal_collection_hash = L9_2
        L13_2.decal_name_hash = L10_2
        L14_2 = true
        L11_2(L12_2, L13_2, L14_2)
      end
    end
    L3_2 = pairs
    L4_2 = A0_2.props
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = tonumber
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L7_2 = L9_2
      L9_2 = UsablePropHashToData
      L10_2 = L2_2
      L11_2 = L8_2
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = L9_2.drawableId
      if L10_2 < 0 then
        L10_2 = ClearPedProp
        L11_2 = GetShopPed
        L11_2 = L11_2()
        L12_2 = L7_2
        L10_2(L11_2, L12_2)
      else
        L10_2 = SetPedPropIndex
        L11_2 = GetShopPed
        L11_2 = L11_2()
        L12_2 = L7_2
        L13_2 = L9_2.drawableId
        L14_2 = L9_2.textureId
        L15_2 = true
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
      end
      if A1_2 then
        L10_2 = ShopSetPropByHash
        L11_2 = L7_2
        L12_2 = L8_2
        L10_2(L11_2, L12_2)
      end
    end
  end
  if A1_2 then
    L3_2 = GetCurrentPedData
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L0_1 = L3_2
  end
end
ShopPreviewOutfit = L10_1
function L10_1(A0_2)
  local L1_2
  L1_2 = 1885233650 == A0_2 or -1667301416 == A0_2
  return L1_2
end
IsModelFreemode = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = IsModelFreemode
  L2_2 = GetEntityModel
  L3_2 = A0_2
  L2_2, L3_2 = L2_2(L3_2)
  return L1_2(L2_2, L3_2)
end
IsPedFreemode = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = LoadAndSetModel
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L1_1 = L1_2
  L1_2 = IsModelFreemode
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L2_2 = ApplyDefaultHeadblend
    L3_2 = A0_2
    L4_2 = L1_1
    L2_2(L3_2, L4_2)
  end
  L2_2 = SetPedDefaultComponentVariation
  L3_2 = L1_1
  L2_2(L3_2)
  if L1_2 then
    L2_2 = RcoreSetPedComponentVariation
    L3_2 = L1_1
    L4_2 = 2
    L5_2 = 2
    L6_2 = 0
    L7_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = CustomSetDefaultVariations
    L3_2 = L1_1
    L2_2(L3_2)
  end
  L7_1 = A0_2
end
ShopPreviewPedModel = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L7_1
  L0_2 = false ~= L0_2
  return L0_2
end
ShopIsPrevieweingPedModel = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = false
  L7_1 = L0_2
  L0_2 = GetEntityModel
  L1_2 = L1_1
  L0_2 = L0_2(L1_2)
  L0_1.pedModel = L0_2
  L0_2 = ShopInit
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L0_2(L1_2)
end
ShopConfirmPedModel = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = ShopIsPrevieweingPedModel
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = LoadAndSetModel
    L1_2 = L0_1.pedModel
    L0_2(L1_2)
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_1 = L0_2
    L0_2 = false
    L7_1 = L0_2
    L0_2 = ResetEverything
    L0_2()
  end
end
ShopResetPedModel = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = pairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 >= 100 then
      L6_2 = L6_2 - 100
      L7_2 = L0_1.props
      L7_2 = L7_2[L6_2]
      if L7_2 then
        L8_2 = L7_2[1]
        if L8_2 < 0 then
          L8_2 = ClearPedProp
          L9_2 = L1_1
          L10_2 = L6_2
          L8_2(L9_2, L10_2)
        else
          L8_2 = SetPedPropIndex
          L9_2 = L1_1
          L10_2 = L6_2
          L11_2 = L7_2[1]
          L12_2 = L7_2[2]
          L13_2 = true
          L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
        end
      end
    else
      L7_2 = nil
      L8_2 = nil
      if 8 == L6_2 then
        L9_2 = L0_1.decal8
        if L9_2 then
          L9_2 = L0_1.decal8
          L9_2 = L9_2[1]
          L10_2 = L0_1.decal8
          L8_2 = L10_2[2]
          L7_2 = L9_2
      end
      elseif 11 == L6_2 then
        L9_2 = L0_1.decal11
        if L9_2 then
          L9_2 = L0_1.decal11
          L9_2 = L9_2[1]
          L10_2 = L0_1.decal11
          L8_2 = L10_2[2]
          L7_2 = L9_2
        end
      end
      L9_2 = L0_1.components
      L9_2 = L9_2[L6_2]
      L10_2 = ApplyPedClothingItem
      L11_2 = L1_1
      L12_2 = {}
      L13_2 = L6_2
      L14_2 = "_"
      L15_2 = L9_2[1]
      L16_2 = "_"
      L17_2 = L9_2[2]
      L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2 .. L17_2
      L12_2.name_hash = L13_2
      L12_2.decal_collection_hash = L7_2
      L12_2.decal_name_hash = L8_2
      L13_2 = true
      L10_2(L11_2, L12_2, L13_2)
    end
  end
end
ResetComponent = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = IsDebuggingImages
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = InvisibilityMakeInvisible
    L1_2 = GetEntityModel
    L2_2 = PlayerPedId
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    return
  end
  L0_2 = GetShopPed
  L0_2 = L0_2()
  L1_2 = UnshrinkHead
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = 0
  L2_2 = 7
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = ResetComponent
    L6_2 = {}
    L7_2 = L4_2 + 100
    L6_2[1] = L7_2
    L5_2(L6_2)
  end
  L1_2 = 0
  L2_2 = 11
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = ResetComponent
    L6_2 = {}
    L7_2 = L4_2
    L6_2[1] = L7_2
    L5_2(L6_2)
  end
  L1_2 = ShopHeadblendReset
  L1_2()
  L1_2 = ShopFaceFeatureReset
  L1_2()
  L1_2 = ShopEyeColorReset
  L1_2()
  L1_2 = ShopHairReset
  L1_2()
  L1_2 = ShopHeadOverlayReset
  L1_2()
  L1_2 = ShopResetPedModel
  L1_2()
  L1_2 = EnsureHeadShrink
  L1_2()
end
ResetEverything = L10_1
