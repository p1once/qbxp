local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = 0
L1_1 = {}
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = L0_1
  L1_2 = L1_2 + 1
  L2_2 = TriggerServerEvent
  L3_2 = "rcore_clothing:requestSkinByIdentifier"
  L4_2 = L1_2
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = GetGameTimer
  L2_2 = L2_2()
  while true do
    L3_2 = L1_1
    L3_2 = L3_2[L1_2]
    if L3_2 then
      break
    end
    L3_2 = GetGameTimer
    L3_2 = L3_2()
    L3_2 = L3_2 - L2_2
    L4_2 = 2000
    if not (L3_2 < L4_2) then
      break
    end
    L3_2 = Wait
    L4_2 = 0
    L3_2(L4_2)
  end
  L3_2 = L1_1
  L3_2 = L3_2[L1_2]
  L4_2 = L1_1
  L4_2[L1_2] = nil
  return L3_2
end
GetSkinByIdentifier = L2_1
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:responseSkinByIdentifier"
function L4_1(A0_2, A1_2)
  local L2_2
  L2_2 = L1_1
  L2_2[A0_2] = A1_2
end
L2_1(L3_1, L4_1)
