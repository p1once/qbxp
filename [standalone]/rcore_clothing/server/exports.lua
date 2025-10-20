local L0_1, L1_1, L2_1, L3_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = DbGetCurrentOutfit
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = #L1_2
  if L2_2 > 0 then
    L2_2 = L1_2[1]
    L3_2 = {}
    L4_2 = L2_2.ped_model
    L3_2.ped_model = L4_2
    L4_2 = json
    L4_2 = L4_2.decode
    L5_2 = L2_2.outfit
    L4_2 = L4_2(L5_2)
    L3_2.skin = L4_2
    return L3_2
  else
    L2_2 = {}
    return L2_2
  end
end
L1_1 = exports
L2_1 = "getSkinByIdentifier"
L3_1 = L0_1
L1_1(L2_1, L3_1)
