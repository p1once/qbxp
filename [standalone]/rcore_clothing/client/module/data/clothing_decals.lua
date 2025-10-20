local L0_1, L1_1, L2_1
L0_1 = {}
L1_1 = false
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = L0_1
    L2_2 = {}
    L1_2[A0_2] = L2_2
  end
  L1_2 = GetNumTattooShopDlcItems
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = 500
  L3_2 = 0
  L4_2 = L1_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = MyGetTattooShopDlcItemData
    L8_2 = A0_2
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = L0_1
    L8_2 = L8_2[A0_2]
    L9_2 = L7_2.NameHash
    L8_2[L9_2] = L7_2
    L2_2 = L2_2 - 1
    if L2_2 < 0 then
      L2_2 = 500
      L8_2 = Wait
      L9_2 = 0
      L8_2(L9_2)
    end
  end
  L3_2 = true
  L1_1 = L3_2
end
PrecomputeTattooCache = L2_1
function L2_1()
  local L0_2, L1_2
  L0_2 = L1_1
  return L0_2
end
IsTattooCacheReady = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L3_2 = ClearPedDecorations
  L4_2 = A1_2
  L3_2(L4_2)
  L3_2 = GetShopPedApparelVariantComponentCount
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  if L3_2 > 0 then
    L5_2 = 0
    L6_2 = L3_2 - 1
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = nil
      L10_2 = nil
      L11_2 = GetVariantComponent
      L12_2 = A2_2
      L13_2 = L8_2
      L11_2, L12_2, L13_2 = L11_2(L12_2, L13_2)
      if 10 == L13_2 then
        L14_2 = L0_1
        L14_2 = L14_2[A0_2]
        L14_2 = L14_2[L11_2]
        if L14_2 then
          L14_2 = SetPedDecoration
          L15_2 = A1_2
          L16_2 = L0_1
          L16_2 = L16_2[A0_2]
          L16_2 = L16_2[L11_2]
          L16_2 = L16_2.CollectionHash
          L17_2 = L0_1
          L17_2 = L17_2[A0_2]
          L17_2 = L17_2[L11_2]
          L17_2 = L17_2.NameHash
          L14_2(L15_2, L16_2, L17_2)
          L14_2 = Wait
          L15_2 = 100
          L14_2(L15_2)
          L14_2 = GetPedDecorations
          L15_2 = A1_2
          L14_2 = L14_2(L15_2)
          L14_2 = #L14_2
          if L14_2 > 0 then
            L14_2 = table
            L14_2 = L14_2.insert
            L15_2 = L4_2
            L16_2 = {}
            L17_2 = L0_1
            L17_2 = L17_2[A0_2]
            L17_2 = L17_2[L11_2]
            L17_2 = L17_2.CollectionHash
            L16_2.CollectionHash = L17_2
            L17_2 = L0_1
            L17_2 = L17_2[A0_2]
            L17_2 = L17_2[L11_2]
            L17_2 = L17_2.NameHash
            L16_2.DecorationNameHash = L17_2
            L17_2 = ResolvePrice
            L18_2 = L0_1
            L18_2 = L18_2[A0_2]
            L18_2 = L18_2[L11_2]
            L18_2 = L18_2.Price
            L17_2 = L17_2(L18_2)
            L16_2.Price = L17_2
            L17_2 = L0_1
            L17_2 = L17_2[A0_2]
            L17_2 = L17_2[L11_2]
            L17_2 = L17_2.Label
            L16_2.Label = L17_2
            L14_2(L15_2, L16_2)
          else
          end
          L14_2 = ClearPedDecorations
          L15_2 = A1_2
          L14_2(L15_2)
        end
      end
    end
  end
  return L4_2
end
GetDecalVariations = L2_1
