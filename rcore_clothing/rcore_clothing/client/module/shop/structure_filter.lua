local L0_1, L1_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if "items" ~= L6_2 then
      L1_2[L6_2] = L7_2
    end
  end
  return L1_2
end
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if not A1_2 then
    return A0_2
  end
  L2_2 = {}
  L3_2 = pairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = {}
    L10_2 = pairs
    L11_2 = L8_2.items
    L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
    for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
      L16_2 = L15_2.id
      L16_2 = A1_2[L16_2]
      if L16_2 then
        L16_2 = table
        L16_2 = L16_2.insert
        L17_2 = L9_2
        L18_2 = L15_2
        L16_2(L17_2, L18_2)
      end
    end
    L10_2 = #L9_2
    if L10_2 > 0 then
      L10_2 = L0_1
      L11_2 = L8_2
      L10_2 = L10_2(L11_2)
      L10_2.items = L9_2
      L11_2 = table
      L11_2 = L11_2.insert
      L12_2 = L2_2
      L13_2 = L10_2
      L11_2(L12_2, L13_2)
    end
  end
  return L2_2
end
FilterShopStructure = L1_1
