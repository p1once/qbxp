local L0_1, L1_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L2_2 = GetShopPedApparelForcedComponentCount
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = 3
  L4_2 = 10
  L5_2 = {}
  L6_2 = 0
  L7_2 = L2_2 - 1
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = nil
    L11_2 = nil
    L12_2 = GetForcedComponent
    L13_2 = A1_2
    L14_2 = L9_2
    L12_2, L13_2, L14_2 = L12_2(L13_2, L14_2)
    if L14_2 == L3_2 then
      if 0 == L12_2 or 1849449579 == L12_2 then
        L10_2 = L13_2
        L11_2 = 0
      else
        L15_2 = GetShopPedComponent
        L16_2 = L12_2
        L15_2 = L15_2(L16_2)
        L16_2 = L15_2.Drawable
        if L16_2 then
          L14_2 = L15_2.ComponentType
          L10_2 = L15_2.Drawable
          L11_2 = L15_2.Texture
          shouldShortSleep = true
        else
          L10_2 = L13_2
          L11_2 = 0
        end
      end
      L15_2 = IsPedComponentVariationValid
      L16_2 = A0_2
      L17_2 = L14_2
      L18_2 = L10_2
      L19_2 = L11_2
      L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
      if L15_2 then
        L15_2 = table
        L15_2 = L15_2.insert
        L16_2 = L5_2
        L17_2 = {}
        L17_2.nameHash = L12_2
        L17_2.componentId = L14_2
        L17_2.drawableId = L10_2
        L17_2.textureId = L11_2
        L15_2(L16_2, L17_2)
      end
    elseif L14_2 == L4_2 then
      if 0 == L12_2 or 1849449579 == L12_2 then
      else
        L15_2 = GetShopPedComponent
        L16_2 = L12_2
        L15_2 = L15_2(L16_2)
        if L15_2 then
          L16_2 = L15_2.Drawable
          if L16_2 > 0 then
            L16_2 = IsPedComponentVariationValid
            L17_2 = A0_2
            L18_2 = L15_2.ComponentType
            L19_2 = L15_2.Drawable
            L20_2 = L15_2.Texture
            L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2)
            if L16_2 then
              L16_2 = table
              L16_2 = L16_2.insert
              L17_2 = L5_2
              L18_2 = {}
              L18_2.nameHash = L12_2
              L19_2 = L15_2.ComponentType
              L18_2.componentId = L19_2
              L19_2 = L15_2.Drawable
              L18_2.drawableId = L19_2
              L19_2 = L15_2.Texture
              L18_2.textureId = L19_2
              L16_2(L17_2, L18_2)
            end
          end
        end
      end
    elseif 0 == L12_2 or 1849449579 == L12_2 then
    else
      L15_2 = GetShopPedComponent
      L16_2 = L12_2
      L15_2 = L15_2(L16_2)
      if L15_2 then
        L16_2 = L15_2.Drawable
        if L16_2 > 0 then
          L16_2 = IsPedComponentVariationValid
          L17_2 = A0_2
          L18_2 = L15_2.ComponentType
          L19_2 = L15_2.Drawable
          L20_2 = L15_2.Texture
          L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2)
          if L16_2 then
            L16_2 = table
            L16_2 = L16_2.insert
            L17_2 = L5_2
            L18_2 = {}
            L18_2.nameHash = L12_2
            L19_2 = L15_2.ComponentType
            L18_2.componentId = L19_2
            L19_2 = L15_2.Drawable
            L18_2.drawableId = L19_2
            L19_2 = L15_2.Texture
            L18_2.textureId = L19_2
            L16_2(L17_2, L18_2)
          end
        end
      end
    end
  end
  return L5_2
end
GetForcedComponents = L0_1
