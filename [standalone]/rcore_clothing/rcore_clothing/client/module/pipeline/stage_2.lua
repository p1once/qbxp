local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1
L0_1 = vector3
L1_1 = 0.0
L2_1 = 0.0
L3_1 = 0.0
L0_1 = L0_1(L1_1, L2_1, L3_1)
L1_1 = false
function L2_1()
  local L0_2, L1_2
  L0_2 = L0_1
  return L0_2
end
GetAnimRot = L2_1
function L2_1(A0_2)
  local L1_2
  L0_1 = A0_2
end
SetAnimRot = L2_1
L2_1 = false
function L3_1()
  local L0_2, L1_2
  L0_2 = false
  L2_1 = L0_2
end
StopStage2Anim = L3_1
L3_1 = false
L4_1 = nil
L5_1 = nil
L6_1 = AddEventHandler
L7_1 = "onResourceStop"
function L8_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = ClearTimecycleModifier
    L1_2()
    L1_2 = print
    L2_2 = "Clearing ped tasks because"
    L3_2 = GetCurrentResourceName
    L3_2 = L3_2()
    L4_2 = "is stopping"
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = FreezeEntityPosition
    L2_2 = PlayerPedId
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = ClearPedTasksImmediately
    L2_2 = PlayerPedId
    L2_2, L3_2, L4_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2)
  end
end
L6_1(L7_1, L8_1)
function L6_1()
  local L0_2, L1_2
  L0_2 = true
  L2_1 = L0_2
  L0_2 = RequestAnimDict
  L1_2 = "move_m@generic"
  L0_2(L1_2)
  while true do
    L0_2 = HasAnimDictLoaded
    L1_2 = "move_m@generic"
    L0_2 = L0_2(L1_2)
    if L0_2 then
      break
    end
    L0_2 = Wait
    L1_2 = 100
    L0_2(L1_2)
  end
  L0_2 = Citizen
  L0_2 = L0_2.CreateThreadNow
  function L1_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L0_3 = GetEntityCoords
    L1_3 = PlayerPedId
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L1_3()
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L1_3 = GetEntityRotation
    L2_3 = PlayerPedId
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L2_3()
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L0_1 = L1_3
    while true do
      L1_3 = L2_1
      if not L1_3 then
        break
      end
      L1_3 = TaskPlayAnimAdvanced
      L2_3 = PlayerPedId
      L2_3 = L2_3()
      L3_3 = "move_m@generic"
      L4_3 = "idle"
      L5_3 = L0_3
      L6_3 = L0_1
      L7_3 = 0.0
      L8_3 = 0.0
      L9_3 = 1000
      L10_3 = 2
      L11_3 = 0
      L12_3 = false
      L13_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
      L1_3 = HideHudAndRadarThisFrame
      L1_3()
      L1_3 = ThefeedHideThisFrame
      L1_3()
      L1_3 = SetRainLevel
      L2_3 = 0.0
      L1_3(L2_3)
      L1_3 = SetWeatherTypePersist
      L2_3 = "EXTRASUNNY"
      L1_3(L2_3)
      L1_3 = SetWeatherTypeNow
      L2_3 = "EXTRASUNNY"
      L1_3(L2_3)
      L1_3 = SetWeatherTypeNowPersist
      L2_3 = "EXTRASUNNY"
      L1_3(L2_3)
      L1_3 = Wait
      L2_3 = 0
      L1_3(L2_3)
    end
  end
  L0_2(L1_2)
end
SetAnim = L6_1
L6_1 = RegisterNetEvent
L7_1 = "rcore_clothing:pipelineInitStage2"
function L8_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  L4_2 = StopDrawingPhotosWarning
  L4_2()
  L4_2 = ResetIsStage4
  L4_2()
  L3_1 = A2_2
  L4_1 = A3_2
  L4_2 = print
  L5_2 = "Setting model to"
  L6_2 = A0_2
  L4_2(L5_2, L6_2)
  L4_2 = LoadAndSetModel
  L5_2 = A0_2
  L4_2(L5_2)
  L4_2 = print
  L5_2 = "Loaded model..."
  L4_2(L5_2)
  L4_2 = SetEntityCoords
  L5_2 = PlayerPedId
  L5_2 = L5_2()
  L6_2 = 53.91
  L7_2 = 164.21
  L8_2 = -114.55
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = SetEntityHeading
  L5_2 = PlayerPedId
  L5_2 = L5_2()
  L6_2 = 270.0
  L4_2(L5_2, L6_2)
  L4_2 = FreezeEntityPosition
  L5_2 = PlayerPedId
  L5_2 = L5_2()
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = SetTimecycleModifier
  L5_2 = "rcore_clothing_tc"
  L4_2(L5_2)
  L4_2 = SetAnim
  L4_2()
  L4_2 = Wait
  L5_2 = 500
  L4_2(L5_2)
  L4_2 = GetEntityHealth
  L5_2 = PlayerPedId
  L5_2, L6_2, L7_2, L8_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_1 = L4_2
  L4_2 = Pipeline2HandleConfirmAllrightDialog
  L5_2 = A1_2
  L4_2(L5_2)
end
L6_1(L7_1, L8_1)
function L6_1()
  local L0_2, L1_2
  L0_2 = true
  L1_1 = L0_2
end
Pipeline2ForceStop = L6_1
L6_1 = RegisterNUICallback
L7_1 = "pipeline2forceStop"
function L8_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = Pipeline2ForceStop
  L2_2()
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L6_1(L7_1, L8_1)
L6_1 = RegisterNetEvent
L7_1 = "rcore_clothing:receiveDataToProcess"
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  L3_2 = print
  L4_2 = "Received items:"
  L5_2 = #A1_2
  L4_2 = L4_2 .. L5_2
  L3_2(L4_2)
  L3_2 = L1_1
  if not L3_2 then
    L3_2 = #A1_2
    if not (L3_2 <= 0) then
      goto lbl_71
    end
  end
  L3_2 = ClearTimecycleModifier
  L3_2()
  L3_2 = BackdropStop
  L3_2()
  L3_2 = ClothingCamStop
  L3_2()
  L3_2 = StopStage2Anim
  L3_2()
  L3_2 = FreezeEntityPosition
  L4_2 = PlayerPedId
  L4_2 = L4_2()
  L5_2 = false
  L3_2(L4_2, L5_2)
  L3_2 = Wait
  L4_2 = 1000
  L3_2(L4_2)
  L3_2 = L1_1
  if not L3_2 then
    L3_2 = GetEntityModel
    L4_2 = PlayerPedId
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L4_2()
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    if 1885233650 == L3_2 then
      L3_2 = TriggerEvent
      L4_2 = "rcore_clothing:pipelineInitStage2"
      L5_2 = -1667301416
      L6_2 = A0_2
      L7_2 = L3_1
      L8_2 = compId
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  end
  else
    L3_2 = SetPedDefaultComponentVariation
    L4_2 = PlayerPedId
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L4_2()
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L3_2 = ClearPedTasksImmediately
    L4_2 = PlayerPedId
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L4_2()
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L3_2 = SetPedDefaultComponentVariation
    L4_2 = PlayerPedId
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L4_2()
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L3_2 = TriggerServerEvent
    L4_2 = "rcore_clothing:reloadSkin"
    L3_2(L4_2)
  end
  L3_2 = L1_1
  if not L3_2 then
    L3_2 = ShowInfoDialog
    L4_2 = "pipeline_done"
    L5_2 = "Addon process done"
    L6_2 = "No more items to process for this ped! You can now close this window."
    L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = false
  L1_1 = L3_2
  do return end
  ::lbl_71::
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = L3_1
  if not L4_2 then
    L4_2 = ClothingCamSetup
    L5_2 = L3_2
    L6_2 = CAM_OFFSETS_PROCESSING
    L7_2 = A1_2[1]
    L7_2 = L7_2.component_id
    L4_2(L5_2, L6_2, L7_2)
  else
    L4_2 = IsClothingFreeCamActive
    L4_2 = L4_2()
    if not L4_2 then
      L4_2 = ClothingSetupFreeCam
      L5_2 = L3_2
      L6_2 = CAM_OFFSETS_PROCESSING
      L7_2 = 11
      L4_2(L5_2, L6_2, L7_2)
    end
  end
  L4_2 = BackdropSetupForPed
  L5_2 = L3_2
  L6_2 = {}
  L7_2 = 0
  L8_2 = 255
  L9_2 = 0
  L10_2 = 255
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L6_2[4] = L10_2
  L7_2 = true
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = Wait
  L5_2 = 500
  L4_2(L5_2)
  L4_2 = L0_1
  L5_2 = 0
  L6_2 = nil
  L7_2 = nil
  L8_2 = InvisibilityMakeInvisible
  L9_2 = GetEntityModel
  L10_2 = PlayerPedId
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L10_2()
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L8_2 = Wait
  L9_2 = 2000
  L8_2(L9_2)
  L8_2 = TakePhotoEmptynessTest
  L9_2 = A0_2
  L8_2, L9_2 = L8_2(L9_2)
  if not L8_2 then
    L10_2 = print
    L11_2 = "Failed green screen test, some resource is probably drawing something on screen."
    L12_2 = A1_2[1]
    L12_2 = L12_2.component_id
    L10_2(L11_2, L12_2)
    L10_2 = print
    L11_2 = "Image: "
    L12_2 = L9_2
    L10_2(L11_2, L12_2)
    L10_2 = ShowInfoDialog
    L11_2 = "pipeline_failed_gs"
    L12_2 = "Failed to take photo"
    L13_2 = "Check the URL below to see what went wrong. If there is anything other than green screen on the photo, try to hide it. <br><br>If you want to contact rcore support, copy the link and send it into your ticket."
    L14_2 = L9_2
    L10_2(L11_2, L12_2, L13_2, L14_2)
    L10_2 = BackdropStop
    L10_2()
    L10_2 = StopStage2Anim
    L10_2()
    L10_2 = FreezeEntityPosition
    L11_2 = PlayerPedId
    L11_2 = L11_2()
    L12_2 = false
    L10_2(L11_2, L12_2)
    L10_2 = L3_1
    if not L10_2 then
      L10_2 = ClothingCamStop
      L10_2()
    else
      L10_2 = ClothingStopFreeCam
      L10_2()
    end
    return
  end
  L10_2 = DisplayPipelineStatus
  L11_2 = A2_2
  L12_2 = L3_1
  L10_2(L11_2, L12_2)
  L10_2 = pairs
  L11_2 = A1_2
  L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
  for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
    L16_2 = L1_1
    if L16_2 then
      L16_2 = ShowNotification
      L17_2 = "Addon pipeline manually stopped. To continue later, start the step again."
      L16_2(L17_2)
      break
    end
    L16_2 = L5_1
    L17_2 = GetEntityHealth
    L18_2 = PlayerPedId
    L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L18_2()
    L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L16_2 = L16_2 - L17_2
    if L16_2 > 10 then
      L16_2 = HidePipelineStatus
      L16_2()
      L16_2 = print
      L17_2 = "Player took damage, stopping pipeline. You might be dying of starvation"
      L16_2(L17_2)
      L16_2 = ShowInfoDialog
      L17_2 = "pipeline_failed_hp"
      L18_2 = "Addon process stopped"
      L19_2 = "Player took damage, stopping pipeline. You might be dying of starvation."
      L16_2(L17_2, L18_2, L19_2)
      L16_2 = BackdropStop
      L16_2()
      L16_2 = StopStage2Anim
      L16_2()
      L16_2 = FreezeEntityPosition
      L17_2 = PlayerPedId
      L17_2 = L17_2()
      L18_2 = false
      L16_2(L17_2, L18_2)
      L16_2 = L3_1
      if not L16_2 then
        L16_2 = ClothingCamStop
        L16_2()
      else
        L16_2 = ClothingStopFreeCam
        L16_2()
      end
      return
    end
    L16_2 = UpdatePipelineStatus
    L17_2 = L14_2
    L16_2(L17_2)
    L16_2 = print
    L17_2 = "Screenshotting"
    L18_2 = L15_2.component_id
    L19_2 = L15_2.drawable_id
    L20_2 = L15_2.texture_id
    L16_2(L17_2, L18_2, L19_2, L20_2)
    L5_2 = L15_2.id
    L16_2 = PlayerPedId
    L16_2 = L16_2()
    L3_2 = L16_2
    L16_2 = InvisibilityMakeInvisible
    L17_2 = GetEntityModel
    L18_2 = L3_2
    L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L17_2(L18_2)
    L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L16_2 = ClearPedDecorations
    L17_2 = L3_2
    L16_2(L17_2)
    L16_2 = L15_2.component_id
    if 2 == L16_2 then
      L16_2 = GetEntityModel
      L17_2 = L3_2
      L16_2 = L16_2(L17_2)
      if -1667301416 == L16_2 then
        L16_2 = SetPedHeadBlendData
        L17_2 = L3_2
        L18_2 = 31
        L19_2 = 0
        L20_2 = 0
        L21_2 = 0
        L22_2 = 0
        L23_2 = 0
        L24_2 = 0.0
        L25_2 = 0.0
        L26_2 = 0.0
        L27_2 = true
        L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
      else
        L16_2 = SetPedHeadBlendData
        L17_2 = L3_2
        L18_2 = 0
        L19_2 = 0
        L20_2 = 0
        L21_2 = 0
        L22_2 = 0
        L23_2 = 0
        L24_2 = 0.0
        L25_2 = 0.0
        L26_2 = 0.0
        L27_2 = true
        L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
      end
      L16_2 = SetPedHairTint
      L17_2 = L3_2
      L18_2 = 8
      L19_2 = 0
      L16_2(L17_2, L18_2, L19_2)
      L16_2 = SetPedComponentVariation
      L17_2 = L3_2
      L18_2 = L15_2.component_id
      L19_2 = L15_2.drawable_id
      L20_2 = 0
      L21_2 = 0
      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2)
    else
      L16_2 = ApplyPedClothingItem
      L17_2 = L3_2
      L18_2 = L15_2
      L19_2 = true
      L20_2 = true
      L16_2(L17_2, L18_2, L19_2, L20_2)
    end
    L16_2 = L3_1
    if not L16_2 then
      L16_2 = ClothingCamSetComponent
      L17_2 = L3_2
      L18_2 = CAM_OFFSETS_PROCESSING
      L19_2 = L15_2.component_id
      L16_2(L17_2, L18_2, L19_2)
    else
      L16_2 = L15_2.component_id
      if L6_2 == L16_2 then
        L16_2 = L15_2.drawable_id
        if L7_2 == L16_2 then
          goto lbl_300
        end
      end
      L16_2 = ClothingControlFreeCam
      L16_2()
    end
    ::lbl_300::
    L16_2 = L1_1
    if L16_2 then
      break
    end
    L16_2 = ClearPedTasksImmediately
    L17_2 = PlayerPedId
    L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L17_2()
    L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L16_2 = L3_1
    if not L16_2 then
      L16_2 = L15_2.component_id
      if 5 == L16_2 then
        L16_2 = vector3
        L17_2 = 0.0
        L18_2 = 0.0
        L19_2 = 180.0
        L16_2 = L16_2(L17_2, L18_2, L19_2)
        L16_2 = L4_2 + L16_2
        L0_1 = L16_2
      end
    end
    while true do
      L16_2 = BusyspinnerIsOn
      L16_2 = L16_2()
      if not L16_2 then
        break
      end
      L16_2 = Wait
      L17_2 = 0
      L16_2(L17_2)
    end
    L16_2 = Wait
    L17_2 = 100
    L16_2(L17_2)
    while true do
      L16_2 = BusyspinnerIsOn
      L16_2 = L16_2()
      if not L16_2 then
        break
      end
      L16_2 = Wait
      L17_2 = 0
      L16_2(L17_2)
    end
    L16_2 = ResolveItemToClothingOrPropItem
    L17_2 = PlayerPedId
    L17_2 = L17_2()
    L18_2 = L15_2
    L16_2 = L16_2(L17_2, L18_2)
    L17_2 = TakePhotoWithRetry
    L18_2 = L15_2.id
    L19_2 = A0_2
    L20_2 = GetEntityModel
    L21_2 = L3_2
    L20_2 = L20_2(L21_2)
    L21_2 = L16_2.componentId
    L22_2 = L16_2.drawableId
    L23_2 = L16_2.textureId
    L24_2 = L15_2.name_hash
    L25_2 = L16_2.decalCollectionHash
    if not L25_2 then
      L25_2 = 0
    end
    L26_2 = L16_2.decalNameHash
    if not L26_2 then
      L26_2 = 0
    end
    L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L6_2 = L15_2.component_id
    L7_2 = L15_2.drawable_id
    L0_1 = L4_2
  end
  L10_2 = HidePipelineStatus
  L10_2()
  L10_2 = BackdropStop
  L10_2()
  L10_2 = L3_1
  if not L10_2 then
    L10_2 = ClothingCamStop
    L10_2()
  else
    L10_2 = ClothingStopFreeCam
    L10_2()
  end
  L10_2 = TriggerServerEvent
  L11_2 = "rcore_clothing:getDataToProcess"
  L12_2 = GetEntityModel
  L13_2 = PlayerPedId
  L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L13_2()
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L13_2 = L5_2
  L14_2 = L3_1
  L15_2 = L4_1
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
end
L6_1(L7_1, L8_1)
function L6_1(A0_2, A1_2, A2_2)
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
  L4_2 = 1.0
  L5_2 = 1.0
  L3_2(L4_2, L5_2)
  L3_2 = SetTextDropShadow
  L3_2()
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
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = GetTimeSinceLastInput
  L1_2 = L1_2()
  L2_2 = Wait
  L3_2 = 0
  L2_2(L3_2)
  L2_2 = Wait
  L3_2 = 0
  L2_2(L3_2)
  while true do
    L2_2 = GetTimeSinceLastInput
    L2_2 = L2_2()
    if not (L1_2 < L2_2) then
      break
    end
    L2_2 = L6_1
    L3_2 = 0.3
    L4_2 = 0.4
    L5_2 = "~g~Move your mouse to start the process"
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = Wait
    L3_2 = 0
    L2_2(L3_2)
  end
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = ClothingCamSetup
  L4_2 = L2_2
  L5_2 = CAM_OFFSETS_PROCESSING
  L6_2 = 11
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = BackdropSetupForPed
  L4_2 = L2_2
  L5_2 = {}
  L6_2 = 0
  L7_2 = 255
  L8_2 = 0
  L9_2 = 255
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  L5_2[4] = L9_2
  L6_2 = true
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = InvisibilityMakeInvisible
  L4_2 = GetEntityModel
  L5_2 = L2_2
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2(L5_2)
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = SetPedComponentVariation
  L4_2 = L2_2
  L5_2 = 11
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = GetEntityModel
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if -1667301416 == L3_2 then
    L3_2 = ApplyPedClothingItem
    L4_2 = L2_2
    L5_2 = {}
    L5_2.name_hash = -2029594620
    L6_2 = true
    L7_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2)
  else
    L3_2 = ApplyPedClothingItem
    L4_2 = L2_2
    L5_2 = {}
    L5_2.name_hash = -2006797141
    L6_2 = true
    L7_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
  L3_2 = Wait
  L4_2 = 1000
  L3_2(L4_2)
  L3_2 = TakePhotoWithRetryAndReturnImage
  L4_2 = A0_2
  L3_2, L4_2 = L3_2(L4_2)
  if nil == L3_2 then
    L5_2 = print
    L6_2 = "ERROR: Could not take photo"
    L7_2 = L4_2
    L5_2(L6_2, L7_2)
    L5_2 = ShowInfoDialog
    L6_2 = "pipeline_failed"
    L7_2 = "Failed to take photo"
    L8_2 = "Check the URL below to see what went wrong. <br><br>If you want to contact rcore support, copy the link and send it into your ticket."
    L9_2 = L4_2
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = BackdropStop
    L5_2()
    L5_2 = ClothingCamStop
    L5_2()
    L5_2 = ClearPedTasksImmediately
    L6_2 = PlayerPedId
    L6_2, L7_2, L8_2, L9_2 = L6_2()
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = FreezeEntityPosition
    L6_2 = PlayerPedId
    L6_2 = L6_2()
    L7_2 = false
    L5_2(L6_2, L7_2)
  else
    L5_2 = ShowPipelineConfirmDialog
    L6_2 = L3_2
    L5_2(L6_2)
  end
end
Pipeline2HandleConfirmAllrightDialog = L7_1
function L7_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = TriggerServerEvent
  L1_2 = "rcore_clothing:getDataToProcess"
  L2_2 = GetEntityModel
  L3_2 = PlayerPedId
  L3_2, L4_2, L5_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = 0
  L4_2 = L3_1
  L5_2 = L4_1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
end
OnPipeline2DialogConfirm = L7_1
function L7_1()
  local L0_2, L1_2, L2_2
  L0_2 = BackdropStop
  L0_2()
  L0_2 = StopStage2Anim
  L0_2()
  L0_2 = ClothingCamStop
  L0_2()
  L0_2 = ClearPedTasksImmediately
  L1_2 = PlayerPedId
  L1_2, L2_2 = L1_2()
  L0_2(L1_2, L2_2)
  L0_2 = FreezeEntityPosition
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L2_2 = false
  L0_2(L1_2, L2_2)
end
OnPipeline2DialogCancel = L7_1
