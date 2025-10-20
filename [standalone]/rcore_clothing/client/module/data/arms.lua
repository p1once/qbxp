local L0_1, L1_1
function L0_1(A0_2)
  local L1_2
  L1_2 = DataGetArmConfig
  L1_2 = L1_2()
  L1_2 = L1_2[A0_2]
  if not L1_2 then
    L1_2 = {}
    return L1_2
  end
  L1_2 = DataGetArmConfig
  L1_2 = L1_2()
  L1_2 = L1_2[A0_2]
  return L1_2
end
GetAvailableGloves = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = DataGetArms
  L1_2 = L1_2()
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == A0_2 then
      L8_2 = true
      return L8_2
    end
  end
  L2_2 = false
  return L2_2
end
IsBaseArms = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "string" ~= L1_2 then
    L1_2 = print
    L2_2 = "ERROR: armsHash must be a string because some arms dont have a hash"
    L1_2(L2_2)
  end
  L1_2 = pairs
  L2_2 = DataGetArmConfig
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ipairs
    L8_2 = L6_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      if L12_2 == A0_2 then
        L13_2 = L11_2
        L14_2 = L5_2
        return L13_2, L14_2
      end
    end
  end
  L1_2 = nil
  return L1_2
end
GetBaseArmsFromHash = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = ipairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == A1_2 then
      L8_2 = L6_2
      L9_2 = baseArms
      return L8_2, L9_2
    end
  end
  L2_2 = nil
  return L2_2
end
GetGloveIndex = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = GetShopPed
  L1_2 = L1_2()
  if not L1_2 then
    L1_2 = PlayerPedId
    L1_2 = L1_2()
  end
  L2_2 = GetEntityModel
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if 1885233650 == L2_2 then
    L3_2 = "nondlcgta5--3--4--0" == A0_2
    return L3_2
  elseif -1667301416 == L2_2 then
    L3_2 = "nondlcgta5--3--11--0" == A0_2 or "nondlcgta5--3--3--0" == A0_2
    return L3_2
  end
end
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = GetBaseArmsFromHash
  L3_2 = A0_2
  L2_2, L3_2 = L2_2(L3_2)
  L4_2 = GetAvailableGloves
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = L0_1
  L6_2 = L3_2
  L5_2 = L5_2(L6_2)
  if L5_2 then
    L5_2 = FilterOutUniques
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    L4_2 = L5_2
  end
  L5_2 = GetGloveIndex
  L6_2 = L4_2
  L7_2 = A0_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = GetAvailableGloves
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L7_2 = L0_1
  L8_2 = A1_2
  L7_2 = L7_2(L8_2)
  if L7_2 then
    L7_2 = FilterOutUniques
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L6_2 = L7_2
  end
  if nil == L5_2 then
    L7_2 = L6_2[1]
    return L7_2
  end
  L7_2 = #L6_2
  L8_2 = #L4_2
  if 61 ~= L7_2 and 71 ~= L7_2 then
    L9_2 = L6_2[1]
    return L9_2
  end
  if 61 ~= L8_2 and 71 ~= L8_2 then
    L9_2 = L6_2[1]
    return L9_2
  end
  if L7_2 == L8_2 then
    L9_2 = L6_2[L5_2]
    return L9_2
  end
  L9_2 = DataGetGapData
  L9_2 = L9_2()
  if 61 == L8_2 and 71 == L7_2 then
    L10_2 = L9_2.start
    if L5_2 > L10_2 then
      L10_2 = L9_2.length
      L10_2 = L5_2 + L10_2
      L10_2 = L6_2[L10_2]
      return L10_2
    end
    L10_2 = L6_2[L5_2]
    return L10_2
  end
  if 71 == L8_2 and 61 == L7_2 then
    L10_2 = L9_2.start
    if L5_2 > L10_2 then
      L10_2 = L9_2.start
      L11_2 = L9_2.length
      L10_2 = L10_2 + L11_2
      if L5_2 < L10_2 then
        L10_2 = L6_2[1]
        return L10_2
      end
      L10_2 = L9_2.length
      L10_2 = L5_2 - L10_2
      L10_2 = L6_2[L10_2]
      return L10_2
    else
      L10_2 = L6_2[L5_2]
      return L10_2
    end
  end
  L10_2 = L6_2[1]
  return L10_2
end
GetEquivalentGlovesFromHash = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = {}
  L2_2 = ipairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = DataGetArmConfigIgnore
    L8_2 = L8_2()
    L8_2 = L8_2[L7_2]
    if not L8_2 then
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L1_2
      L10_2 = L7_2
      L8_2(L9_2, L10_2)
    end
  end
  return L1_2
end
FilterOutUniques = L1_1
