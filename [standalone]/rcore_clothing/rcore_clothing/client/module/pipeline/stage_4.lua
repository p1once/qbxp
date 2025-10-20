local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = nil
L1_1 = false
function L2_1()
  local L0_2, L1_2
  L0_2 = false
  L1_1 = L0_2
end
ResetIsStage4 = L2_1
function L2_1()
  local L0_2, L1_2
  L0_2 = L1_1
  return L0_2
end
IsStage4 = L2_1
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:pipelineInitStage4"
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = StopDrawingPhotosWarning
  L2_2()
  L2_2 = true
  L1_1 = L2_2
  L2_2 = print
  L3_2 = "Setting model to"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = LoadAndSetModel
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = print
  L3_2 = "Loaded model..."
  L2_2(L3_2)
  L2_2 = SetEntityCoords
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = 53.91
  L5_2 = 164.21
  L6_2 = -114.55
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = SetEntityHeading
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = 270.0
  L2_2(L3_2, L4_2)
  L2_2 = FreezeEntityPosition
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = SetTimecycleModifier
  L3_2 = "rcore_clothing_tc"
  L2_2(L3_2)
  L2_2 = SetAnim
  L2_2()
  L2_2 = Wait
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = GetEntityHealth
  L3_2 = PlayerPedId
  L3_2, L4_2, L5_2, L6_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L0_1 = L2_2
  L2_2 = Pipeline2HandleConfirmAllrightDialog
  L3_2 = A1_2
  L2_2(L3_2)
end
L2_1(L3_1, L4_1)
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:receiveStage4DataToProcess"
function L4_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L3_2 = print
  L4_2 = "Received items:"
  L5_2 = #A1_2
  L4_2 = L4_2 .. L5_2
  L3_2(L4_2)
  L3_2 = #A1_2
  if L3_2 <= 0 then
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
    L3_2 = GetEntityModel
    L4_2 = PlayerPedId
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L4_2()
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    if 1885233650 == L3_2 then
      L3_2 = TriggerEvent
      L4_2 = "rcore_clothing:pipelineInitStage4"
      L5_2 = -1667301416
      L6_2 = A0_2
      L3_2(L4_2, L5_2, L6_2)
    else
      L3_2 = SetPedDefaultComponentVariation
      L4_2 = PlayerPedId
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L4_2()
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L3_2 = ClearPedTasksImmediately
      L4_2 = PlayerPedId
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L4_2()
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L3_2 = SetPedDefaultComponentVariation
      L4_2 = PlayerPedId
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L4_2()
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    end
    L3_2 = ShowInfoDialog
    L4_2 = "pipeline_done"
    L5_2 = "Addon process done"
    L6_2 = "No more items to process for this ped! You can now close this window."
    L3_2(L4_2, L5_2, L6_2)
    return
  end
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = ClothingSetupFreeCam
  L5_2 = L3_2
  L6_2 = CAM_OFFSETS_PROCESSING
  L7_2 = 888
  L4_2(L5_2, L6_2, L7_2)
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
  L4_2 = GetAnimRot
  L4_2 = L4_2()
  L5_2 = 0
  L6_2 = nil
  L7_2 = nil
  L8_2 = InvisibilityMakeInvisible
  L9_2 = GetEntityModel
  L10_2 = PlayerPedId
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L10_2()
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
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
    L10_2 = ClothingCamStop
    L10_2()
    return
  end
  L10_2 = DisplayPipelineStatus
  L11_2 = A2_2
  L12_2 = false
  L13_2 = true
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = pairs
  L11_2 = A1_2
  L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
  for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
    L16_2 = L0_1
    L17_2 = GetEntityHealth
    L18_2 = PlayerPedId
    L18_2, L19_2, L20_2, L21_2 = L18_2()
    L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
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
      L16_2 = ClothingCamStop
      L16_2()
      return
    end
    L16_2 = UpdatePipelineStatus
    L17_2 = L14_2
    L16_2(L17_2)
    L16_2 = print
    L17_2 = "Validating"
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
    L17_2, L18_2, L19_2, L20_2, L21_2 = L17_2(L18_2)
    L16_2(L17_2, L18_2, L19_2, L20_2, L21_2)
    L16_2 = ClearPedDecorations
    L17_2 = L3_2
    L16_2(L17_2)
    L16_2 = ApplyPedClothingItem
    L17_2 = L3_2
    L18_2 = L15_2
    L19_2 = true
    L20_2 = true
    L16_2(L17_2, L18_2, L19_2, L20_2)
    L16_2 = ClothingCamSetComponent
    L17_2 = L3_2
    L18_2 = CAM_OFFSETS_PROCESSING
    L19_2 = 888
    L16_2(L17_2, L18_2, L19_2)
    L16_2 = ClearPedTasksImmediately
    L17_2 = PlayerPedId
    L17_2, L18_2, L19_2, L20_2, L21_2 = L17_2()
    L16_2(L17_2, L18_2, L19_2, L20_2, L21_2)
    L16_2 = L15_2.component_id
    if 5 == L16_2 then
      L16_2 = SetAnimRot
      L17_2 = vector3
      L18_2 = 0.0
      L19_2 = 0.0
      L20_2 = 180.0
      L17_2 = L17_2(L18_2, L19_2, L20_2)
      L17_2 = L4_2 + L17_2
      L16_2(L17_2)
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
    L17_2 = TakePhotoEmptynessTest
    L18_2 = A0_2
    L17_2, L18_2 = L17_2(L18_2)
    if L17_2 then
      L19_2 = TriggerServerEvent
      L20_2 = "rcore_clothing:stage4SoftBlacklist"
      L21_2 = L15_2.id
      L19_2(L20_2, L21_2)
    end
    L6_2 = L15_2.component_id
    L7_2 = L15_2.drawable_id
    L19_2 = SetAnimRot
    L20_2 = L4_2
    L19_2(L20_2)
  end
  L10_2 = HidePipelineStatus
  L10_2()
  L10_2 = BackdropStop
  L10_2()
  L10_2 = ClothingCamStop
  L10_2()
  L10_2 = TriggerServerEvent
  L11_2 = "rcore_clothing:getStage4DataToProcess"
  L12_2 = GetEntityModel
  L13_2 = PlayerPedId
  L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L13_2()
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L13_2 = L5_2
  L10_2(L11_2, L12_2, L13_2)
end
L2_1(L3_1, L4_1)
function L2_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = TriggerServerEvent
  L1_2 = "rcore_clothing:getStage4DataToProcess"
  L2_2 = GetEntityModel
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L2_2, L3_2 = L2_2(L3_2)
  L0_2(L1_2, L2_2, L3_2)
end
OnPipeline4DialogConfirm = L2_1
