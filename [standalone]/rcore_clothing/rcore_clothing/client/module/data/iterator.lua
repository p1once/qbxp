local L0_1, L1_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L5_2 = GetEntityModel
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  model = L5_2
  L5_2 = A1_2
  if 110 == L5_2 or 111 == L5_2 then
    L5_2 = 11
  end
  if 80 == L5_2 or 81 == L5_2 then
    L5_2 = 8
  end
  L6_2 = GetNumberOfPedDrawableVariations
  L7_2 = A0_2
  L8_2 = L5_2
  L6_2 = L6_2(L7_2, L8_2)
  L6_2 = L6_2 - 1
  L7_2 = 0
  L8_2 = L6_2
  L9_2 = math
  L9_2 = L9_2.floor
  L10_2 = L6_2 / 2
  L9_2 = L9_2(L10_2)
  if 110 == A1_2 or 80 == A1_2 then
    L7_2 = 0
    L8_2 = L9_2
  end
  if 111 == A1_2 or 81 == A1_2 then
    L7_2 = L9_2 + 1
    L8_2 = L6_2
  end
  L10_2 = L7_2
  L11_2 = L8_2
  L12_2 = 1
  for L13_2 = L10_2, L11_2, L12_2 do
    L14_2 = GetNumberOfPedTextureVariations
    L15_2 = A0_2
    L16_2 = L5_2
    L17_2 = L13_2
    L14_2 = L14_2(L15_2, L16_2, L17_2)
    L14_2 = L14_2 - 1
    L15_2 = 0
    L16_2 = L14_2
    L17_2 = 1
    for L18_2 = L15_2, L16_2, L17_2 do
      L19_2 = L18_2
      if 2 == L5_2 then
        L19_2 = 0
      end
      L20_2 = IsPedComponentVariationValid
      L21_2 = A0_2
      L22_2 = L5_2
      L23_2 = L13_2
      L24_2 = L19_2
      L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2)
      L21_2 = IsPedComponentVariationGen9Exclusive
      L22_2 = A0_2
      L23_2 = L5_2
      L24_2 = L13_2
      L21_2 = L21_2(L22_2, L23_2, L24_2)
      L21_2 = not L21_2
      if L20_2 and L21_2 then
        L22_2 = Wait
        L23_2 = A2_2
        L22_2(L23_2)
        L22_2 = A4_2
        L23_2 = model
        L24_2 = L5_2
        L25_2 = L13_2
        L26_2 = L18_2
        L22_2(L23_2, L24_2, L25_2, L26_2)
        L22_2 = Wait
        L23_2 = A3_2
        L22_2(L23_2)
      end
    end
  end
end
IterateOverVariations = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L5_2 = GetEntityModel
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  model = L5_2
  L5_2 = GetNumberOfPedPropDrawableVariations
  L6_2 = A0_2
  L7_2 = A1_2
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = L5_2 - 1
  L6_2 = 0
  L7_2 = L5_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = GetNumberOfPedPropTextureVariations
    L11_2 = A0_2
    L12_2 = A1_2
    L13_2 = L9_2
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L10_2 = L10_2 - 1
    L11_2 = 0
    L12_2 = L10_2
    L13_2 = 1
    for L14_2 = L11_2, L12_2, L13_2 do
      L15_2 = Wait
      L16_2 = A2_2
      L15_2(L16_2)
      L15_2 = A4_2
      L16_2 = model
      L17_2 = A1_2
      L18_2 = L9_2
      L19_2 = L14_2
      L15_2(L16_2, L17_2, L18_2, L19_2)
      L15_2 = Wait
      L16_2 = A3_2
      L15_2(L16_2)
    end
  end
  L6_2 = ClearPedProp
  L7_2 = A0_2
  L8_2 = A1_2
  L6_2(L7_2, L8_2)
end
IterateOverProps = L0_1
