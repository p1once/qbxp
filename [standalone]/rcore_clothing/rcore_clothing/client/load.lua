local L0_1, L1_1, L2_1
L0_1 = RegisterNetEvent
L1_1 = "rcore_clothing:setPlayerClothing"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = GetEntityHealth
  L4_2 = PlayerPedId
  L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L4_2 = GetPedArmour
  L5_2 = PlayerPedId
  L5_2, L6_2, L7_2, L8_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = ApplyPlayerClothingOnSpawn
  L6_2 = A1_2
  L7_2 = A0_2
  L8_2 = A2_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = SetEntityHealth
  L6_2 = PlayerPedId
  L6_2 = L6_2()
  L7_2 = L3_2
  L5_2(L6_2, L7_2)
  L5_2 = SetPedArmour
  L6_2 = PlayerPedId
  L6_2 = L6_2()
  L7_2 = L4_2
  L5_2(L6_2, L7_2)
end
L0_1(L1_1, L2_1)
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = GetEntityModel
  L4_2 = PlayerPedId
  L4_2, L5_2, L6_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if L3_2 ~= A0_2 or A2_2 then
    L3_2 = LoadAndSetModel
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = SetPedDefaultComponentVariation
    L4_2 = PlayerPedId
    L4_2, L5_2, L6_2 = L4_2()
    L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = ApplyPedClothingOutfit
  L5_2 = L3_2
  L6_2 = A1_2
  L4_2(L5_2, L6_2)
  L4_2 = TriggerEvent
  L5_2 = "rcore_clothing:afterSkinLoaded"
  L4_2(L5_2)
end
ApplyPlayerClothingOnSpawn = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = ApplyPedClothingOutfit
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = TriggerEvent
  L4_2 = "rcore_clothing:afterSkinLoaded"
  L3_2(L4_2)
end
ApplyPedClothing = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L3_2 = IsPedFreemode
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = A1_2.headblend
    if L3_2 then
      L3_2 = SetPedHeadBlendData
      L4_2 = A0_2
      L5_2 = A1_2.headblend
      L5_2 = L5_2.maleModel
      L6_2 = A1_2.headblend
      L6_2 = L6_2.femaleModel
      L7_2 = 0
      L8_2 = A1_2.headblend
      L8_2 = L8_2.maleTone
      L9_2 = A1_2.headblend
      L9_2 = L9_2.femaleTone
      L10_2 = 0
      L11_2 = A1_2.headblend
      L11_2 = L11_2.modelBlend
      L11_2 = L11_2 / 10
      L11_2 = L11_2 * 10
      L12_2 = A1_2.headblend
      L12_2 = L12_2.toneBlend
      L12_2 = L12_2 / 10
      L12_2 = L12_2 * 10
      L13_2 = 0.0
      L14_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    elseif not A2_2 then
      L3_2 = SetPedHeadBlendData
      L4_2 = A0_2
      L5_2 = 0
      L6_2 = 0
      L7_2 = 0
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0.0
      L12_2 = 0.0
      L13_2 = 0.0
      L14_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    end
    if not A2_2 then
      L3_2 = SetPedDefaultComponentVariation
      L4_2 = A0_2
      L3_2(L4_2)
      L3_2 = CustomSetDefaultVariations
      L4_2 = A0_2
      L3_2(L4_2)
      L3_2 = ClearAllPedProps
      L4_2 = A0_2
      L3_2(L4_2)
    end
  end
  L3_2 = A1_2.faceFeatures
  if L3_2 then
    L3_2 = pairs
    L4_2 = A1_2.faceFeatures
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = tonumber
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L7_2 = L9_2
      L9_2 = tonumber
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      L8_2 = L9_2 + 0.0
      L9_2 = SetPedFaceFeature
      L10_2 = A0_2
      L11_2 = L7_2
      L12_2 = L8_2
      L9_2(L10_2, L11_2, L12_2)
    end
  end
  L3_2 = A1_2.components
  if L3_2 then
    L3_2 = pairs
    L4_2 = A1_2.components
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      if "2" == L7_2 then
        L9_2 = A1_2.hair
        if L9_2 then
          goto lbl_122
        end
      end
      L9_2 = tonumber
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L7_2 = L9_2
      L9_2 = UsableHashToData
      L10_2 = A0_2
      L11_2 = L8_2
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 then
        L10_2 = L9_2.componentId
        if L10_2 then
          L10_2 = ApplyPedClothingItem
          L11_2 = A0_2
          L12_2 = {}
          L12_2.name_hash = L8_2
          L13_2 = decCol
          L12_2.decal_collection_hash = L13_2
          L13_2 = decName
          L12_2.decal_name_hash = L13_2
          L10_2(L11_2, L12_2)
        end
      end
      ::lbl_122::
    end
  end
  L3_2 = A1_2.props
  if L3_2 then
    L3_2 = pairs
    L4_2 = A1_2.props
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = tonumber
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L7_2 = L9_2
      L9_2 = UsablePropHashToData
      L10_2 = A0_2
      L11_2 = L8_2
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 then
        L10_2 = L9_2.componentId
        if L10_2 then
          L10_2 = SetPedPropIndex
          L11_2 = A0_2
          L12_2 = L9_2.componentId
          L13_2 = L9_2.drawableId
          L14_2 = L9_2.textureId
          L15_2 = true
          L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
        end
      end
    end
  end
  L3_2 = A1_2.headOverlay
  if L3_2 then
    L3_2 = pairs
    L4_2 = A1_2.headOverlay
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = tonumber
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L7_2 = L9_2
      L9_2 = SetPedHeadOverlay
      L10_2 = A0_2
      L11_2 = L7_2
      L12_2 = L8_2.id
      L13_2 = L8_2.opacity
      L9_2(L10_2, L11_2, L12_2, L13_2)
      L9_2 = 0
      if 2 == L7_2 or 1 == L7_2 or 10 == L7_2 then
        L9_2 = 1
      elseif 5 == L7_2 or 8 == L7_2 or 4 == L7_2 then
        L9_2 = 2
      end
      L10_2 = SetPedHeadOverlayColor
      L11_2 = A0_2
      L12_2 = L7_2
      L13_2 = L9_2
      L14_2 = L8_2.color1
      if not L14_2 then
        L14_2 = 0
      end
      L15_2 = L8_2.color2
      if not L15_2 then
        L15_2 = 0
      end
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
    end
  end
  L3_2 = A1_2.eyeColor
  if L3_2 then
    L3_2 = SetPedEyeColor
    L4_2 = A0_2
    L5_2 = A1_2.eyeColor
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2.hair
  if L3_2 then
    L3_2 = A1_2.hair
    L3_2 = L3_2.id
    if L3_2 then
      L3_2 = type
      L4_2 = A1_2.hair
      L4_2 = L4_2.id
      L3_2 = L3_2(L4_2)
      if "number" == L3_2 then
        L3_2 = A1_2.hair
        L4_2 = "2_"
        L5_2 = A1_2.hair
        L5_2 = L5_2.id
        L6_2 = "_0"
        L4_2 = L4_2 .. L5_2 .. L6_2
        L3_2.id = L4_2
      end
      L3_2 = ApplyPedClothingItem
      L4_2 = A0_2
      L5_2 = {}
      L6_2 = A1_2.hair
      L6_2 = L6_2.id
      L5_2.name_hash = L6_2
      L3_2(L4_2, L5_2)
      L3_2 = SetPedHairColor
      L4_2 = A0_2
      L5_2 = A1_2.hair
      L5_2 = L5_2.color1
      L6_2 = A1_2.hair
      L6_2 = L6_2.color2
      L3_2(L4_2, L5_2, L6_2)
    end
  end
end
ApplyPedClothingOutfit = L0_1
