local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1
L0_1 = false
L1_1 = nil
L2_1 = nil
L3_1 = nil
L4_1 = false
function L5_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L4_2 = ClothingCacheOffsets
  L5_2 = A1_2
  L6_2 = A2_2
  L4_2(L5_2, L6_2)
  L4_2 = A2_2[A3_2]
  L4_2 = L4_2.precomputedCamPos
  L5_2 = A2_2[A3_2]
  L5_2 = L5_2.precomputedCamLookAt
  L6_2 = SetCamCoord
  L7_2 = A0_2
  L8_2 = L4_2
  L6_2(L7_2, L8_2)
  L6_2 = SetCamRot
  L7_2 = A0_2
  L8_2 = vector3
  L9_2 = -8.0
  L10_2 = 0.0
  L11_2 = 90.0
  L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2, L10_2, L11_2)
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
end
function L6_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = IsControlPressed
  L2_2 = 0
  L3_2 = A0_2
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L1_2 = IsDisabledControlPressed
    L2_2 = 0
    L3_2 = A0_2
    L1_2 = L1_2(L2_2, L3_2)
  end
  return L1_2
end
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = GetControlNormal
  L2_2 = 0
  L3_2 = A0_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = GetDisabledControlNormal
  L3_2 = 0
  L4_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2)
  L1_2 = L1_2 + L2_2
  return L1_2
end
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L3_2 = DisableAllControlActions
  L4_2 = 0
  L3_2(L4_2)
  L3_2 = GetFrameTime
  L3_2 = L3_2()
  L4_2 = 0.2
  L5_2 = 0.8
  L6_2 = L3_2 * A1_2
  L7_2 = L3_2 * A1_2
  L7_2 = L7_2 * L5_2
  L8_2 = L7_1
  L9_2 = 1
  L8_2 = L8_2(L9_2)
  L8_2 = L8_2 * L3_2
  L8_2 = L8_2 * A2_2
  L9_2 = L7_1
  L10_2 = 2
  L9_2 = L9_2(L10_2)
  L9_2 = L9_2 * L3_2
  L9_2 = L9_2 * A2_2
  L10_2 = SetCamNearClip
  L11_2 = A0_2
  L12_2 = 0.0
  L10_2(L11_2, L12_2)
  L10_2 = SetCamNearDof
  L11_2 = A0_2
  L12_2 = 0.0
  L10_2(L11_2, L12_2)
  L10_2 = GetCamRot
  L11_2 = A0_2
  L12_2 = 2
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = SetCamRot
  L12_2 = A0_2
  L13_2 = math
  L13_2 = L13_2.max
  L14_2 = -70.0
  L15_2 = math
  L15_2 = L15_2.min
  L16_2 = 70.0
  L17_2 = L10_2.x
  L17_2 = L17_2 - L9_2
  L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L15_2(L16_2, L17_2)
  L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L14_2 = 0.0
  L15_2 = L10_2.z
  L15_2 = L15_2 - L8_2
  L16_2 = 2
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  L11_2 = GetCamMatrix
  L12_2 = A0_2
  L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
  L15_2 = L6_1
  L16_2 = 21
  L15_2 = L15_2(L16_2)
  if L15_2 then
    L6_2 = L6_2 * L4_2
    L7_2 = L7_2 * L4_2
  end
  L15_2 = L6_1
  L16_2 = 32
  L15_2 = L15_2(L16_2)
  if not L15_2 then
    L15_2 = L6_1
    L16_2 = 87
    L15_2 = L15_2(L16_2)
    if not L15_2 then
      goto lbl_98
    end
  end
  L15_2 = L12_2 * L6_2
  L16_2 = vector3
  L17_2 = L14_2.x
  L18_2 = L15_2.x
  L17_2 = L17_2 + L18_2
  L18_2 = L14_2.y
  L19_2 = L15_2.y
  L18_2 = L18_2 + L19_2
  L19_2 = L14_2.z
  L20_2 = L15_2.z
  L19_2 = L19_2 + L20_2
  L16_2 = L16_2(L17_2, L18_2, L19_2)
  L14_2 = L16_2
  ::lbl_98::
  L15_2 = L6_1
  L16_2 = 33
  L15_2 = L15_2(L16_2)
  if not L15_2 then
    L15_2 = L6_1
    L16_2 = 88
    L15_2 = L15_2(L16_2)
    if not L15_2 then
      goto lbl_125
    end
  end
  L15_2 = L12_2 * L6_2
  L16_2 = vector3
  L17_2 = L14_2.x
  L18_2 = L15_2.x
  L17_2 = L17_2 - L18_2
  L18_2 = L14_2.y
  L19_2 = L15_2.y
  L18_2 = L18_2 - L19_2
  L19_2 = L14_2.z
  L20_2 = L15_2.z
  L19_2 = L19_2 - L20_2
  L16_2 = L16_2(L17_2, L18_2, L19_2)
  L14_2 = L16_2
  ::lbl_125::
  L15_2 = L6_1
  L16_2 = 34
  L15_2 = L15_2(L16_2)
  if not L15_2 then
    L15_2 = L6_1
    L16_2 = 89
    L15_2 = L15_2(L16_2)
    if not L15_2 then
      goto lbl_152
    end
  end
  L15_2 = L11_2 * L7_2
  L16_2 = vector3
  L17_2 = L14_2.x
  L18_2 = L15_2.x
  L17_2 = L17_2 - L18_2
  L18_2 = L14_2.y
  L19_2 = L15_2.y
  L18_2 = L18_2 - L19_2
  L19_2 = L14_2.z
  L20_2 = L15_2.z
  L19_2 = L19_2 - L20_2
  L16_2 = L16_2(L17_2, L18_2, L19_2)
  L14_2 = L16_2
  ::lbl_152::
  L15_2 = L6_1
  L16_2 = 35
  L15_2 = L15_2(L16_2)
  if not L15_2 then
    L15_2 = L6_1
    L16_2 = 90
    L15_2 = L15_2(L16_2)
    if not L15_2 then
      goto lbl_179
    end
  end
  L15_2 = L11_2 * L7_2
  L16_2 = vector3
  L17_2 = L14_2.x
  L18_2 = L15_2.x
  L17_2 = L17_2 + L18_2
  L18_2 = L14_2.y
  L19_2 = L15_2.y
  L18_2 = L18_2 + L19_2
  L19_2 = L14_2.z
  L20_2 = L15_2.z
  L19_2 = L19_2 + L20_2
  L16_2 = L16_2(L17_2, L18_2, L19_2)
  L14_2 = L16_2
  ::lbl_179::
  L15_2 = L2_1
  if L15_2 then
    L15_2 = SetCamCoord
    L16_2 = A0_2
    L17_2 = L2_1.x
    L18_2 = L2_1.y
    L19_2 = L2_1.z
    L15_2(L16_2, L17_2, L18_2, L19_2)
    L15_2 = SetCamRot
    L16_2 = A0_2
    L17_2 = L3_1.x
    L18_2 = L3_1.y
    L19_2 = L3_1.z
    L20_2 = 2
    L15_2(L16_2, L17_2, L18_2, L19_2, L20_2)
    L15_2 = nil
    L2_1 = L15_2
    L15_2 = nil
    L3_1 = L15_2
  else
    L15_2 = SetCamCoord
    L16_2 = A0_2
    L17_2 = L14_2.x
    L18_2 = L14_2.y
    L19_2 = L14_2.z
    L15_2(L16_2, L17_2, L18_2, L19_2)
  end
end
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = SetTextFont
  L4_2 = 0
  L3_2(L4_2)
  L3_2 = SetTextColour
  L4_2 = 255
  L5_2 = 255
  L6_2 = 255
  L7_2 = 255
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = SetTextScale
  L4_2 = 0.5
  L5_2 = 0.5
  L3_2(L4_2, L5_2)
  L3_2 = SetTextDropShadow
  L3_2()
  L3_2 = SetTextRightJustify
  L4_2 = true
  L3_2(L4_2)
  L3_2 = BeginTextCommandDisplayText
  L4_2 = "STRING"
  L3_2(L4_2)
  L3_2 = AddTextComponentString
  L4_2 = tostring
  L5_2 = A2_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = EndTextCommandDisplayText
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
end
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = CreateCam
  L5_2 = "DEFAULT_SCRIPTED_CAMERA"
  L6_2 = 1
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = SetCamFov
  L6_2 = L4_2
  L7_2 = 50.0
  L5_2(L6_2, L7_2)
  L5_2 = L5_1
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = A1_2
  L9_2 = A2_2
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = RenderScriptCams
  L6_2 = true
  L7_2 = false
  L8_2 = false
  L9_2 = 0
  L10_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = true
  L0_1 = L5_2
  L1_1 = L4_2
end
ClothingSetupFreeCam = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = 1
  L1_2 = 400
  L2_2 = true
  L4_1 = L2_2
  while true do
    L2_2 = L0_1
    if not L2_2 then
      break
    end
    L2_2 = Wait
    L3_2 = 0
    L2_2(L3_2)
    L2_2 = L9_1
    L3_2 = 0.1
    L4_2 = 0.37
    L5_2 = "[WSAD | MOUSE] Move"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L9_1
    L3_2 = 0.1
    L4_2 = 0.4
    L5_2 = "[SPACE] Take picture"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L9_1
    L3_2 = 0.1
    L4_2 = 0.43
    L5_2 = "[SHIFT] Hold for slow cam"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L9_1
    L3_2 = 0.1
    L4_2 = 0.46
    L5_2 = "[/rcp_save name] Save preset"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L9_1
    L3_2 = 0.1
    L4_2 = 0.49
    L5_2 = "[/rcp_load name] Load preset"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L9_1
    L3_2 = 0.1
    L4_2 = 0.52
    L5_2 = "[/rcp_list] List saved presets"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L9_1
    L3_2 = 0.1
    L4_2 = 0.55
    L5_2 = "[/rcp_stop] Stop freecam"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L8_1
    L3_2 = L1_1
    L4_2 = L0_2
    L5_2 = L1_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = IsDisabledControlPressed
    L3_2 = 0
    L4_2 = 353
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = false
      L4_1 = L2_2
      return
    end
  end
end
ClothingControlFreeCam = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = RenderScriptCams
  L1_2 = false
  L2_2 = false
  L3_2 = 0
  L4_2 = true
  L5_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = DestroyCam
  L1_2 = L1_1
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = nil
  L1_1 = L0_2
  L0_2 = false
  L0_1 = L0_2
  L0_2 = false
  L4_1 = L0_2
end
ClothingStopFreeCam = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L1_1
  L0_2 = not L0_2
  L0_2 = not L0_2
  return L0_2
end
IsClothingFreeCamActive = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L4_1
  return L0_2
end
IsClothingFreeCamControlled = L10_1
L10_1 = RegisterCommand
L11_1 = "rcp_save"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = L0_1
  if not L2_2 then
    return
  end
  L2_2 = #A1_2
  if L2_2 < 1 then
    return
  end
  L2_2 = A1_2[1]
  L3_2 = GetRenderingCam
  L3_2 = L3_2()
  L4_2 = GetCamCoord
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = GetCamRot
  L6_2 = L3_2
  L7_2 = 2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = GetResourceKvpString
  L7_2 = "rcp_presets"
  L6_2 = L6_2(L7_2)
  L7_2 = json
  L7_2 = L7_2.decode
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  if not L7_2 then
    L7_2 = {}
  end
  L8_2 = {}
  L8_2.pos = L4_2
  L8_2.rot = L5_2
  L7_2[L2_2] = L8_2
  L8_2 = SetResourceKvp
  L9_2 = "rcp_presets"
  L10_2 = json
  L10_2 = L10_2.encode
  L11_2 = L7_2
  L10_2, L11_2 = L10_2(L11_2)
  L8_2(L9_2, L10_2, L11_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterCommand
L11_1 = "rcp_stop"
function L12_1(A0_2, A1_2)
  local L2_2
  L2_2 = L0_1
  if not L2_2 then
    return
  end
  L2_2 = Pipeline2ForceStop
  L2_2()
  L2_2 = ClothingStopFreeCam
  L2_2()
end
L10_1(L11_1, L12_1)
L10_1 = RegisterCommand
L11_1 = "rcp_load"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L0_1
  if not L2_2 then
    return
  end
  L2_2 = #A1_2
  if L2_2 < 1 then
    return
  end
  L2_2 = A1_2[1]
  L3_2 = GetResourceKvpString
  L4_2 = "rcp_presets"
  L3_2 = L3_2(L4_2)
  L4_2 = json
  L4_2 = L4_2.decode
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = {}
  end
  L5_2 = L4_2[L2_2]
  if not L5_2 then
    return
  end
  L6_2 = GetRenderingCam
  L6_2 = L6_2()
  L7_2 = L5_2.pos
  L2_1 = L7_2
  L7_2 = L5_2.rot
  L3_1 = L7_2
end
L10_1(L11_1, L12_1)
L10_1 = RegisterCommand
L11_1 = "rcp_list"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = L0_1
  if not L2_2 then
    return
  end
  L2_2 = GetResourceKvpString
  L3_2 = "rcp_presets"
  L2_2 = L2_2(L3_2)
  L3_2 = json
  L3_2 = L3_2.decode
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = {}
  end
  L4_2 = ""
  L5_2 = print
  L6_2 = "Camera presets:"
  L5_2(L6_2)
  L5_2 = pairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = print
    L12_2 = "-"
    L13_2 = L9_2
    L11_2(L12_2, L13_2)
    L11_2 = L4_2
    L12_2 = L9_2
    L13_2 = ", "
    L11_2 = L11_2 .. L12_2 .. L13_2
    L4_2 = L11_2
  end
  L5_2 = TriggerEvent
  L6_2 = "chat:addMessage"
  L7_2 = {}
  L8_2 = {}
  L9_2 = 239
  L10_2 = 199
  L11_2 = 80
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L8_2[3] = L11_2
  L7_2.color = L8_2
  L7_2.multiline = true
  L8_2 = {}
  L9_2 = "camera presets"
  L10_2 = L4_2
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L7_2.args = L8_2
  L5_2(L6_2, L7_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterCommand
L11_1 = "rcp_clearall"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L0_1
  if not L2_2 then
    return
  end
  L2_2 = SetResourceKvp
  L3_2 = "rcp_presets"
  L4_2 = "{}"
  L2_2(L3_2, L4_2)
end
L10_1(L11_1, L12_1)
