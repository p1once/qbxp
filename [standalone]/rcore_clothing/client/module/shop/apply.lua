local L0_1, L1_1, L2_1
function L0_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  L4_2 = SetPedPreloadVariationData
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = GetGameTimer
  L4_2 = L4_2()
  while true do
    L5_2 = HasPedPreloadVariationDataFinished
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      break
    end
    L5_2 = GetGameTimer
    L5_2 = L5_2()
    L5_2 = L5_2 - L4_2
    L6_2 = 3000
    if L5_2 > L6_2 then
      L5_2 = print
      L6_2 = "[warning] Preload aborted, timeout. The item probably does not have model assigned"
      L5_2(L6_2)
      break
    end
    L5_2 = Wait
    L6_2 = 0
    L5_2(L6_2)
  end
  L5_2 = Citizen
  L5_2 = L5_2.CreateThread
  function L6_2()
    local L0_3, L1_3
    L0_3 = ReleasePedPreloadVariationData
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2)
end
function L1_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  L4_2 = SetPedPreloadPropData
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = GetGameTimer
  L4_2 = L4_2()
  while true do
    L5_2 = HasPedPreloadPropDataFinished
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      break
    end
    L5_2 = GetGameTimer
    L5_2 = L5_2()
    L5_2 = L5_2 - L4_2
    L6_2 = 3000
    if L5_2 > L6_2 then
      L5_2 = print
      L6_2 = "[warning] Preload aborted, timeout. The item probably does not have model assigned"
      L5_2(L6_2)
      break
    end
    L5_2 = Wait
    L6_2 = 0
    L5_2(L6_2)
  end
end
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = nil
  L3_2 = A1_2.component_id
  if L3_2 then
    L3_2 = A1_2.component_id
    if L3_2 < 100 then
      L3_2 = ResolveClothingItemToData
      L4_2 = A0_2
      L5_2 = A1_2
      L3_2 = L3_2(L4_2, L5_2)
      L2_2 = L3_2
    else
      L3_2 = ResolvePropItemToDataInternalComponent
      L4_2 = A0_2
      L5_2 = A1_2
      L3_2 = L3_2(L4_2, L5_2)
      L2_2 = L3_2
    end
  else
    L3_2 = ResolveClothingItemToData
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2 = L3_2(L4_2, L5_2)
    L2_2 = L3_2
    L3_2 = L2_2.componentId
    if not L3_2 then
      L3_2 = ResolvePropItemToDataInternalComponent
      L4_2 = A0_2
      L5_2 = A1_2
      L3_2 = L3_2(L4_2, L5_2)
      L2_2 = L3_2
    end
  end
  return L2_2
end
ResolveItemToClothingOrPropItem = L2_1
function L2_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = ResolveItemToClothingOrPropItem
  L5_2 = A0_2
  L6_2 = A1_2
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L5_2 = L4_2.componentId
    if L5_2 then
      goto lbl_15
    end
  end
  L5_2 = print
  L6_2 = "Attempting to apply clothing that doesnt exist"
  L7_2 = A1_2.name_hash
  L5_2(L6_2, L7_2)
  do return end
  ::lbl_15::
  L5_2 = L4_2.componentId
  if L5_2 >= 100 then
    L5_2 = L4_2.drawableId
    if L5_2 < 0 then
      L5_2 = ClearPedProp
      L6_2 = A0_2
      L7_2 = L4_2.componentId
      L7_2 = L7_2 - 100
      L5_2(L6_2, L7_2)
    else
      if A3_2 then
        L5_2 = L1_1
        L6_2 = A0_2
        L7_2 = L4_2.componentId
        L7_2 = L7_2 - 100
        L8_2 = L4_2.drawableId
        L9_2 = L4_2.textureId
        L5_2(L6_2, L7_2, L8_2, L9_2)
      end
      L5_2 = SetPedPropIndex
      L6_2 = A0_2
      L7_2 = L4_2.componentId
      L7_2 = L7_2 - 100
      L8_2 = L4_2.drawableId
      L9_2 = L4_2.textureId
      L10_2 = true
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
      if A3_2 then
        L5_2 = ReleasePedPreloadPropData
        L6_2 = A0_2
        L5_2(L6_2)
      end
    end
  else
    L5_2 = L4_2.componentId
    if 3 == L5_2 then
      L5_2 = A1_2.gloves
      if L5_2 then
        if A3_2 then
          L5_2 = L0_1
          L6_2 = A0_2
          L7_2 = L4_2.componentId
          L8_2 = L4_2.drawableId
          L9_2 = L4_2.textureId
          L5_2(L6_2, L7_2, L8_2, L9_2)
        end
        L5_2 = RcoreSetPedComponentVariation
        L6_2 = A0_2
        L7_2 = L4_2.componentId
        L8_2 = L4_2.drawableId
        L9_2 = L4_2.textureId
        L10_2 = L4_2.palette
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
        if A3_2 then
          L5_2 = ReleasePedPreloadVariationData
          L6_2 = A0_2
          L5_2(L6_2)
        end
      else
        L5_2 = IsBaseArms
        L6_2 = A1_2.name_hash
        L5_2 = L5_2(L6_2)
        if L5_2 then
          L5_2 = A1_2.gloves
          if not L5_2 and not A2_2 then
            L5_2 = ApplyArms
            L6_2 = A1_2.name_hash
            L7_2 = L4_2
            L5_2(L6_2, L7_2)
          end
        end
      end
    else
      if A3_2 then
        L5_2 = L0_1
        L6_2 = A0_2
        L7_2 = L4_2.componentId
        L8_2 = L4_2.drawableId
        L9_2 = L4_2.textureId
        L5_2(L6_2, L7_2, L8_2, L9_2)
      end
      L5_2 = RcoreSetPedComponentVariation
      L6_2 = A0_2
      L7_2 = L4_2.componentId
      L8_2 = L4_2.drawableId
      L9_2 = L4_2.textureId
      L10_2 = L4_2.palette
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
      if A3_2 then
        L5_2 = ReleasePedPreloadVariationData
        L6_2 = A0_2
        L5_2(L6_2)
      end
    end
    L5_2 = IsDebuggingImages
    L5_2 = L5_2()
    if not L5_2 then
      L5_2 = A1_2.recommended_arms
      if L5_2 then
        L5_2 = ApplyArms
        L6_2 = A1_2.recommended_arms
        L5_2(L6_2)
      end
    end
  end
end
ApplyPedClothingItem = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = GetPedDrawableVariation
  L4_2 = L2_2
  L5_2 = 3
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = GetPedTextureVariation
  L5_2 = L2_2
  L6_2 = 3
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = GetHashNameForComponent
  L6_2 = L2_2
  L7_2 = 3
  L8_2 = L3_2
  L9_2 = L4_2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = GetUsableHash
  L7_2 = 3
  L8_2 = L3_2
  L9_2 = L4_2
  L10_2 = L5_2
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = GetBaseArmsFromHash
  L8_2 = L6_2
  L7_2, L8_2 = L7_2(L8_2)
  L9_2 = GetEquivalentGlovesFromHash
  L10_2 = L6_2
  L11_2 = A0_2
  L9_2 = L9_2(L10_2, L11_2)
  if L9_2 then
    L10_2 = UsableHashToData
    L11_2 = L2_2
    L12_2 = L9_2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = L10_2.drawableId
    if nil ~= L11_2 then
      L11_2 = RcoreSetPedComponentVariation
      L12_2 = L2_2
      L13_2 = 3
      L14_2 = L10_2.drawableId
      L15_2 = L10_2.textureId
      L16_2 = 0
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
    elseif A1_2 then
      L11_2 = RcoreSetPedComponentVariation
      L12_2 = L2_2
      L13_2 = A1_2.componentId
      L14_2 = A1_2.drawableId
      L15_2 = A1_2.textureId
      L16_2 = A1_2.palette
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
    end
  elseif A1_2 then
    L10_2 = RcoreSetPedComponentVariation
    L11_2 = L2_2
    L12_2 = A1_2.componentId
    L13_2 = A1_2.drawableId
    L14_2 = A1_2.textureId
    L15_2 = A1_2.palette
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
  end
end
ApplyArms = L2_1
