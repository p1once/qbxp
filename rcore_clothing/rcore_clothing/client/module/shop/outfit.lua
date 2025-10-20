local L0_1, L1_1, L2_1, L3_1, L4_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = GetPedPropIndex
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = GetPedPropTextureIndex
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = GetHashNameForProp
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = L2_2
  L8_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = GetUsableHash
  L6_2 = A1_2 + 100
  L7_2 = L2_2
  L8_2 = L3_2
  L9_2 = L4_2
  return L5_2(L6_2, L7_2, L8_2, L9_2)
end
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = {}
  L2_2 = {}
  L1_2.props = L2_2
  L2_2 = {}
  L1_2.components = L2_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = L1_2.props
  L4_2 = L0_1
  L5_2 = L2_2
  L6_2 = 0
  L4_2 = L4_2(L5_2, L6_2)
  L3_2["0"] = L4_2
  L3_2 = L1_2.props
  L4_2 = L0_1
  L5_2 = L2_2
  L6_2 = 1
  L4_2 = L4_2(L5_2, L6_2)
  L3_2["1"] = L4_2
  L3_2 = L1_2.props
  L4_2 = L0_1
  L5_2 = L2_2
  L6_2 = 2
  L4_2 = L4_2(L5_2, L6_2)
  L3_2["2"] = L4_2
  L3_2 = L1_2.props
  L4_2 = L0_1
  L5_2 = L2_2
  L6_2 = 6
  L4_2 = L4_2(L5_2, L6_2)
  L3_2["6"] = L4_2
  L3_2 = L1_2.props
  L4_2 = L0_1
  L5_2 = L2_2
  L6_2 = 7
  L4_2 = L4_2(L5_2, L6_2)
  L3_2["7"] = L4_2
  L3_2 = 0
  L4_2 = 11
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    if 2 ~= L6_2 then
      L7_2 = GetPedDrawableVariation
      L8_2 = L2_2
      L9_2 = L6_2
      L7_2 = L7_2(L8_2, L9_2)
      L8_2 = GetPedTextureVariation
      L9_2 = L2_2
      L10_2 = L6_2
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = GetHashNameForComponent
      L10_2 = L2_2
      L11_2 = L6_2
      L12_2 = L7_2
      L13_2 = L8_2
      L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
      L10_2 = L1_2.components
      L11_2 = tostring
      L12_2 = L6_2
      L11_2 = L11_2(L12_2)
      L12_2 = GetUsableHash
      L13_2 = L6_2
      L14_2 = L7_2
      L15_2 = L8_2
      L16_2 = L9_2
      L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
      L10_2[L11_2] = L12_2
    end
  end
  L3_2 = GetAppliedDecals
  L3_2 = L3_2()
  L4_2 = pairs
  L5_2 = L3_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L1_2.decals
    if not L10_2 then
      L10_2 = {}
      L1_2.decals = L10_2
    end
    L10_2 = L1_2.decals
    L11_2 = tostring
    L12_2 = L8_2
    L11_2 = L11_2(L12_2)
    L12_2 = {}
    L13_2 = L9_2[1]
    L12_2.collection = L13_2
    L13_2 = L9_2[2]
    L12_2.name = L13_2
    L10_2[L11_2] = L12_2
  end
  L4_2 = GetPedEyeColor
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L1_2.eyeColor = L4_2
  if A0_2 then
    L4_2 = GetFormattedPedHeadblendData
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    L5_2 = IsHeadShrinked
    L5_2 = L5_2()
    if L5_2 then
      L5_2 = GetPreShrinkHeadblend
      L5_2 = L5_2()
      L4_2 = L5_2
    end
    L5_2 = {}
    L6_2 = L4_2[1]
    L5_2.maleModel = L6_2
    L6_2 = L4_2[2]
    L5_2.femaleModel = L6_2
    L6_2 = L4_2[4]
    L5_2.maleTone = L6_2
    L6_2 = L4_2[5]
    L5_2.femaleTone = L6_2
    L6_2 = L4_2[7]
    L5_2.modelBlend = L6_2
    L6_2 = L4_2[8]
    L5_2.toneBlend = L6_2
    L1_2.headblend = L5_2
    L5_2 = {}
    L1_2.faceFeatures = L5_2
    L5_2 = IsHeadShrinked
    L5_2 = L5_2()
    if L5_2 then
      L5_2 = GetPreShrink
      L5_2 = L5_2()
      L6_2 = 0
      L7_2 = 19
      L8_2 = 1
      for L9_2 = L6_2, L7_2, L8_2 do
        L10_2 = L1_2.faceFeatures
        L11_2 = tostring
        L12_2 = L9_2
        L11_2 = L11_2(L12_2)
        L12_2 = L5_2[L9_2]
        L10_2[L11_2] = L12_2
      end
    else
      L5_2 = 0
      L6_2 = 19
      L7_2 = 1
      for L8_2 = L5_2, L6_2, L7_2 do
        L9_2 = L1_2.faceFeatures
        L10_2 = tostring
        L11_2 = L8_2
        L10_2 = L10_2(L11_2)
        L11_2 = GetPedFaceFeature
        L12_2 = L2_2
        L13_2 = L8_2
        L11_2 = L11_2(L12_2, L13_2)
        L9_2[L10_2] = L11_2
      end
    end
    L5_2 = {}
    L1_2.headOverlay = L5_2
    L5_2 = 0
    L6_2 = 12
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = GetPedHeadOverlayData
      L10_2 = L2_2
      L11_2 = L8_2
      L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L9_2(L10_2, L11_2)
      if L9_2 then
        L15_2 = L1_2.headOverlay
        L16_2 = tostring
        L17_2 = L8_2
        L16_2 = L16_2(L17_2)
        L17_2 = {}
        L17_2.id = L10_2
        L17_2.color1 = L12_2
        L17_2.color2 = L13_2
        L17_2.opacity = L14_2
        L15_2[L16_2] = L17_2
      end
    end
    L5_2 = 2
    L6_2 = GetPedDrawableVariation
    L7_2 = L2_2
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = GetPedTextureVariation
    L8_2 = L2_2
    L9_2 = L5_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = GetHashNameForComponent
    L9_2 = L2_2
    L10_2 = L5_2
    L11_2 = L6_2
    L12_2 = L7_2
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L9_2 = L1_2.components
    L10_2 = GetUsableHash
    L11_2 = L5_2
    L12_2 = L6_2
    L13_2 = L7_2
    L14_2 = L8_2
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L9_2["2"] = L10_2
    L9_2 = {}
    L10_2 = L1_2.components
    L10_2 = L10_2["2"]
    L9_2.id = L10_2
    L10_2 = GetPedHairColor
    L11_2 = L2_2
    L10_2 = L10_2(L11_2)
    L9_2.color1 = L10_2
    L10_2 = GetPedHairHighlightColor
    L11_2 = L2_2
    L10_2 = L10_2(L11_2)
    L9_2.color2 = L10_2
    L1_2.hair = L9_2
  end
  return L1_2
end
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:saveCurrentSkin"
function L4_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L1_1
  L1_2 = true
  L0_2 = L0_2(L1_2)
  L1_2 = TriggerServerEvent
  L2_2 = "rcore_clothing:setOutfitAsCurrent"
  L3_2 = L0_2
  L1_2(L2_2, L3_2)
end
L2_1(L3_1, L4_1)
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = TriggerServerEvent
  L2_2 = "rcore_clothing:savePersonalOutfit"
  L3_2 = A0_2
  L4_2 = L1_1
  L5_2 = Config
  L5_2 = L5_2.SaveHeadWithOutfit
  L4_2, L5_2 = L4_2(L5_2)
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
SaveCurrentAsOutfit = L2_1
function L2_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L5_2 = TriggerServerEvent
  L6_2 = "rcore_clothing:saveShopOutfit"
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = A3_2
  L11_2 = A4_2
  L12_2 = L1_1
  L12_2 = L12_2()
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
SaveCurrentAsShopOutfit = L2_1
