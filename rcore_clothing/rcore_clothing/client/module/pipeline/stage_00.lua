local L0_1, L1_1, L2_1, L3_1, L4_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = GetPedCollectionNameFromDrawable
  L3_2 = A0_2
  L4_2 = A1_2.componentId
  L5_2 = A1_2.drawableId
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = GetPedCollectionLocalIndexFromDrawable
  L4_2 = A0_2
  L5_2 = A1_2.componentId
  L6_2 = A1_2.drawableId
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if "" == L2_2 then
    L2_2 = "nondlcgta5"
  end
  L4_2 = L2_2
  L5_2 = L3_2
  return L4_2, L5_2
end
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = A1_2.component_id
  if L3_2 >= 100 then
    L3_2 = GetPedCollectionNameFromProp
    L4_2 = A0_2
    L5_2 = A2_2.componentId
    L5_2 = L5_2 - 100
    L6_2 = A2_2.drawableId
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L4_2 = GetPedCollectionLocalIndexFromProp
    L5_2 = A0_2
    L6_2 = A2_2.componentId
    L6_2 = L6_2 - 100
    L7_2 = A2_2.drawableId
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    if "" == L3_2 then
      L3_2 = "nondlcgta5"
    end
    L5_2 = {}
    L5_2.collection = L3_2
    L5_2.index = L4_2
    return L5_2
  end
  L3_2 = L0_1
  L4_2 = A0_2
  L5_2 = A2_2
  L3_2, L4_2 = L3_2(L4_2, L5_2)
  L5_2 = {}
  L5_2.collection = L3_2
  L5_2.index = L4_2
  return L5_2
end
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:stage00:processItems"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L2_2 = print
  L3_2 = "Processing"
  L4_2 = #A0_2
  L5_2 = "remaining"
  L6_2 = A1_2
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = {}
  L3_2 = pairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = PlayerPedId
    L9_2 = L9_2()
    L10_2 = L8_2.ped_model
    L11_2 = GetEntityModel
    L12_2 = L9_2
    L11_2 = L11_2(L12_2)
    if L10_2 ~= L11_2 then
      L10_2 = LoadAndSetModel
      L11_2 = L8_2.ped_model
      L10_2(L11_2)
    end
    L10_2 = PlayerPedId
    L10_2 = L10_2()
    L9_2 = L10_2
    L10_2 = ResolveItemToClothingOrPropItem
    L11_2 = L9_2
    L12_2 = L8_2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = L1_1
    L12_2 = L9_2
    L13_2 = L8_2
    L14_2 = L10_2
    L11_2 = L11_2(L12_2, L13_2, L14_2)
    L12_2 = nil
    L13_2 = L8_2.recommended_arms
    if L13_2 then
      L13_2 = L8_2.recommended_arms
      if "" ~= L13_2 then
        L13_2 = UsableHashToData
        L14_2 = L9_2
        L15_2 = L8_2.recommended_arms
        L13_2 = L13_2(L14_2, L15_2)
        L14_2 = L13_2.componentId
        if L14_2 then
          L14_2 = L13_2.componentId
          if L14_2 > 0 then
            L14_2 = L0_1
            L15_2 = L9_2
            L16_2 = L13_2
            L14_2, L15_2 = L14_2(L15_2, L16_2)
            L16_2 = L14_2
            L17_2 = "--"
            L18_2 = L13_2.componentId
            L19_2 = "--"
            L20_2 = L15_2
            L21_2 = "--"
            L22_2 = L13_2.textureId
            L16_2 = L16_2 .. L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2 .. L22_2
            L12_2 = L16_2
          end
        end
      end
    end
    L13_2 = table
    L13_2 = L13_2.insert
    L14_2 = L2_2
    L15_2 = {}
    L16_2 = L8_2.name_hash
    L15_2.oldHash = L16_2
    L16_2 = L8_2.ped_model
    L15_2.pedModel = L16_2
    L16_2 = L11_2.collection
    if not L16_2 then
      L16_2 = "delme__"
      L17_2 = L7_2
      L16_2 = L16_2 .. L17_2
    end
    L17_2 = "--"
    L18_2 = L10_2.componentId
    if not L18_2 then
      L18_2 = 0
    end
    L19_2 = "--"
    L20_2 = L11_2.index
    L21_2 = "--"
    L22_2 = L10_2.textureId
    if not L22_2 then
      L22_2 = 0
    end
    L16_2 = L16_2 .. L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2 .. L22_2
    L15_2.newHash = L16_2
    L15_2.recArms = L12_2
    L13_2(L14_2, L15_2)
  end
  L3_2 = TriggerServerEvent
  L4_2 = "rcore_clothing:stage00:resolveItems"
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
end
L2_1(L3_1, L4_1)
