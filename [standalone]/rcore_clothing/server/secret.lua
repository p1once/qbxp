local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
L0_1 = nil
L1_1 = {}
L2_1 = 48
L3_1 = 57
L4_1 = 1
for L5_1 = L2_1, L3_1, L4_1 do
  L6_1 = table
  L6_1 = L6_1.insert
  L7_1 = L1_1
  L8_1 = string
  L8_1 = L8_1.char
  L9_1 = L5_1
  L8_1, L9_1 = L8_1(L9_1)
  L6_1(L7_1, L8_1, L9_1)
end
L2_1 = 97
L3_1 = 122
L4_1 = 1
for L5_1 = L2_1, L3_1, L4_1 do
  L6_1 = table
  L6_1 = L6_1.insert
  L7_1 = L1_1
  L8_1 = string
  L8_1 = L8_1.char
  L9_1 = L5_1
  L8_1, L9_1 = L8_1(L9_1)
  L6_1(L7_1, L8_1, L9_1)
end
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if not A0_2 or A0_2 <= 0 then
    L1_2 = ""
    return L1_2
  end
  L1_2 = L2_1
  L2_2 = A0_2 - 1
  L1_2 = L1_2(L2_2)
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 1
  L4_2 = L1_1
  L4_2 = #L4_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L1_1
  L2_2 = L3_2[L2_2]
  L1_2 = L1_2 .. L2_2
  return L1_2
end
L3_1 = Citizen
L3_1 = L3_1.CreateThread
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = math
  L0_2 = L0_2.randomseed
  L1_2 = tonumber
  L2_2 = tostring
  L3_2 = os
  L3_2 = L3_2.time
  L3_2, L4_2, L5_2, L6_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = L2_2
  L2_2 = L2_2.reverse
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2
  L2_2 = L2_2.sub
  L4_2 = 1
  L5_2 = 6
  L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2(L3_2, L4_2, L5_2)
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
  L0_2 = 0
  L1_2 = 50
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = math
    L4_2 = L4_2.random
    L5_2 = 0
    L6_2 = 1000
    L4_2(L5_2, L6_2)
  end
  L0_2 = LoadResourceFile
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  L2_2 = ".rcore_api_key"
  L0_2 = L0_2(L1_2, L2_2)
  if nil == L0_2 then
    L1_2 = L2_1
    L2_2 = 64
    L1_2 = L1_2(L2_2)
    L0_1 = L1_2
    L1_2 = SaveResourceFile
    L2_2 = GetCurrentResourceName
    L2_2 = L2_2()
    L3_2 = ".rcore_api_key"
    L4_2 = L0_1
    L1_2(L2_2, L3_2, L4_2)
  else
    L0_1 = L0_2
  end
end
L3_1(L4_1)
function L3_1()
  local L0_2, L1_2
  L0_2 = L0_1
  return L0_2
end
GetServerSecret = L3_1
