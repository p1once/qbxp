local L0_1, L1_1
L0_1 = false
function L1_1()
  local L0_2, L1_2
  L0_2 = L0_1
  return L0_2
end
GetIsImageDebugging = L1_1
function L1_1()
  local L0_2, L1_2
  L0_2 = L0_1
  return L0_2
end
IsDebuggingImages = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = BackdropForceColor
  L1_2 = {}
  L2_2 = 0
  L3_2 = 255
  L4_2 = 0
  L5_2 = 255
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L0_2(L1_2)
  L0_2 = InvisibilityMakeInvisible
  L1_2 = GetEntityModel
  L2_2 = PlayerPedId
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = true
  L0_1 = L0_2
end
StartImageDebug = L1_1
function L1_1()
  local L0_2, L1_2
  L0_2 = ResetBackdropColor
  L0_2()
  L0_2 = false
  L0_1 = L0_2
  L0_2 = ResetEverything
  L0_2()
end
StopImageDebug = L1_1
