local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1
function L0_1(A0_2)
  local L1_2, L2_2
  L1_2 = RequestAnimDict
  L2_2 = A0_2
  L1_2(L2_2)
  while true do
    L1_2 = HasAnimDictLoaded
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      break
    end
    L1_2 = Wait
    L2_2 = 100
    L1_2(L2_2)
  end
end
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = ConfigPeds
  L1_2 = L1_2.DisableAnimForPeds
  if not L1_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = GetEntityModel
    L9_2 = A0_2
    L8_2 = L8_2(L9_2)
    L9_2 = GetHashKey
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    if L8_2 == L9_2 then
      L8_2 = true
      return L8_2
    end
  end
end
L2_1 = {}
L3_1 = {}
L4_1 = {}
L5_1 = 11
L6_1 = 3
L7_1 = 33
L8_1 = 10
L9_1 = 9
L10_1 = 5
L11_1 = 8
L4_1[1] = L5_1
L4_1[2] = L6_1
L4_1[3] = L7_1
L4_1[4] = L8_1
L4_1[5] = L9_1
L4_1[6] = L10_1
L4_1[7] = L11_1
L3_1.components = L4_1
L3_1.namespace = "clothingshirt"
L4_1 = {}
L5_1 = "try_shirt_positive_a"
L6_1 = "try_shirt_positive_b"
L7_1 = "try_shirt_positive_c"
L8_1 = "try_shirt_positive_d"
L4_1[1] = L5_1
L4_1[2] = L6_1
L4_1[3] = L7_1
L4_1[4] = L8_1
L3_1.anims = L4_1
L2_1.TOP = L3_1
L3_1 = {}
L4_1 = {}
L5_1 = 4
L4_1[1] = L5_1
L3_1.components = L4_1
L3_1.namespace = "clothingtrousers"
L4_1 = {}
L5_1 = "try_trousers_positive_a"
L6_1 = "try_trousers_positive_b"
L7_1 = "try_trousers_positive_c"
L8_1 = "try_trousers_positive_d"
L4_1[1] = L5_1
L4_1[2] = L6_1
L4_1[3] = L7_1
L4_1[4] = L8_1
L3_1.anims = L4_1
L2_1.BOTTOM = L3_1
L3_1 = {}
L4_1 = {}
L5_1 = 6
L4_1[1] = L5_1
L3_1.components = L4_1
L3_1.namespace = "clothingshoes"
L4_1 = {}
L5_1 = "try_shoes_positive_a"
L6_1 = "try_shoes_positive_b"
L7_1 = "try_shoes_positive_c"
L8_1 = "try_shoes_positive_d"
L4_1[1] = L5_1
L4_1[2] = L6_1
L4_1[3] = L7_1
L4_1[4] = L8_1
L3_1.anims = L4_1
L2_1.SHOES = L3_1
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = L1_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    return
  end
  L2_2 = pairs
  L3_2 = L2_1
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = pairs
    L9_2 = L7_2.components
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      if L13_2 == A1_2 then
        L14_2 = AnimPlayPurchaseAnim
        L15_2 = A0_2
        L16_2 = L7_2
        L14_2(L15_2, L16_2)
        return
      end
    end
  end
end
AnimResolveAndPlayPurchaseAnim = L3_1
L3_1 = false
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = L1_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    return
  end
  L2_2 = GetEntityModel
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if -1667301416 == L2_2 then
    L2_2 = "f"
    if L2_2 then
      goto lbl_16
    end
  end
  L2_2 = "m"
  ::lbl_16::
  if A1_2 then
    L3_2 = ClearPedTasksImmediately
    L4_2 = A0_2
    L3_2(L4_2)
  end
  L3_2 = "move_"
  L4_2 = L2_2
  L5_2 = "@generic"
  L3_2 = L3_2 .. L4_2 .. L5_2
  L4_2 = L0_1
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = TaskPlayAnim
  L5_2 = A0_2
  L6_2 = L3_2
  L7_2 = "idle"
  L8_2 = 1.0
  L9_2 = -1.0
  L10_2 = -1
  L11_2 = 1
  L12_2 = 1
  L13_2 = true
  L14_2 = true
  L15_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
end
AnimSetPedStill = L4_1
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = L3_1
  if L2_2 then
    return
  end
  L2_2 = A1_2.namespace
  L3_2 = A1_2.anims
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 1
  L6_2 = A1_2.anims
  L6_2 = #L6_2
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2[L4_2]
  L4_2 = L0_1
  L5_2 = A1_2.namespace
  L4_2(L5_2)
  L4_2 = ClearPedTasks
  L5_2 = A0_2
  L4_2(L5_2)
  L4_2 = TaskPlayAnim
  L5_2 = A0_2
  L6_2 = L2_2
  L7_2 = L3_2
  L8_2 = 1.0
  L9_2 = -1.0
  L10_2 = -1
  L11_2 = 0
  L12_2 = 1
  L13_2 = true
  L14_2 = true
  L15_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L4_2 = true
  L3_1 = L4_2
  L4_2 = GetAnimDuration
  L5_2 = L2_2
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = Citizen
  L5_2 = L5_2.CreateThread
  function L6_2()
    local L0_3, L1_3
    L0_3 = Wait
    L1_3 = L4_2
    L1_3 = L1_3 * 1000
    L0_3(L1_3)
    L0_3 = GetIsNuiOpen
    L0_3 = L0_3()
    if L0_3 then
      L0_3 = AnimSetPedStill
      L1_3 = A0_2
      L0_3(L1_3)
    end
    L0_3 = false
    L3_1 = L0_3
  end
  L5_2(L6_2)
end
AnimPlayPurchaseAnim = L4_1
