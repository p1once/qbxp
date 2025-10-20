local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = {}
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = 4
  if 1885233650 == A0_2 then
    L1_2 = 3
  end
  L2_2 = {}
  L3_2 = 1
  L4_2 = 2
  L5_2 = 3
  L6_2 = 4
  L7_2 = 5
  L8_2 = 6
  L9_2 = 7
  L10_2 = 80
  L11_2 = 81
  L12_2 = 9
  L13_2 = 10
  L14_2 = 110
  L15_2 = 111
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L2_2[8] = L10_2
  L2_2[9] = L11_2
  L2_2[10] = L12_2
  L2_2[11] = L13_2
  L2_2[12] = L14_2
  L2_2[13] = L15_2
  L3_2 = {}
  L4_2 = pairs
  L5_2 = L2_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = Wait
    L11_2 = 0
    L10_2(L11_2)
    L10_2 = GetEntityCoords
    L11_2 = PlayerPedId
    L11_2, L12_2, L13_2, L14_2, L15_2 = L11_2()
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
    L11_2 = Citizen
    L11_2 = L11_2.CreateThread
    function L12_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
      L0_3 = L10_2
      L1_3 = vector3
      L2_3 = L8_2
      L2_3 = L2_3 / 3
      L3_3 = L8_2
      L3_3 = L3_3 % 3
      L3_3 = L3_3 / 2
      L4_3 = 1.0
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      L0_3 = L0_3 + L1_3
      L1_3 = CreatePed
      L2_3 = 0
      L3_3 = A0_2
      L4_3 = L0_3
      L5_3 = 0.0
      L6_3 = false
      L7_3 = false
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      L2_3 = SetBlockingOfNonTemporaryEvents
      L3_3 = L1_3
      L4_3 = true
      L2_3(L3_3, L4_3)
      L2_3 = SetPedHeadBlendData
      L3_3 = L1_3
      L4_3 = 0
      L5_3 = 0
      L6_3 = 0
      L7_3 = 0
      L8_3 = 0
      L9_3 = 0
      L10_3 = 0.0
      L11_3 = 0.0
      L12_3 = 0.0
      L13_3 = false
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
      L3_3 = L9_2
      L2_3 = L3_2
      L4_3 = {}
      L4_3.ped = L1_3
      L4_3.done = false
      L2_3[L3_3] = L4_3
      L2_3 = L0_1
      L2_3[L1_3] = L1_3
      L2_3 = Wait
      L3_3 = 500
      L2_3(L3_3)
      L2_3 = HandleClothingComponent
      L3_3 = L1_3
      L4_3 = A0_2
      L5_3 = L9_2
      L6_3 = L1_2
      L2_3(L3_3, L4_3, L5_3, L6_3)
      L2_3 = L0_1
      L2_3[L1_3] = nil
      L2_3 = DeletePed
      L3_3 = L1_3
      L2_3(L3_3)
      L3_3 = L9_2
      L2_3 = L3_2
      L2_3 = L2_3[L3_3]
      L2_3.done = true
    end
    L11_2(L12_2)
  end
end
L2_1 = RegisterNetEvent
L3_1 = "rcore_clothing:pipelineInitStage1"
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = PrecomputeTattooCache
  L1_2 = 3
  L0_2(L1_2)
  L0_2 = PrecomputeTattooCache
  L1_2 = 4
  L0_2(L1_2)
  while true do
    L0_2 = IsTattooCacheReady
    L0_2 = L0_2()
    if L0_2 then
      break
    end
    L0_2 = Wait
    L1_2 = 0
    L0_2(L1_2)
  end
  L0_2 = RequestModel
  L1_2 = 1885233650
  L0_2(L1_2)
  L0_2 = RequestModel
  L1_2 = -1667301416
  L0_2(L1_2)
  while true do
    L0_2 = HasModelLoaded
    L1_2 = 1885233650
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = HasModelLoaded
      L1_2 = -1667301416
      L0_2 = L0_2(L1_2)
      if L0_2 then
        break
      end
    end
    L0_2 = Wait
    L1_2 = 0
    L0_2(L1_2)
  end
  L0_2 = HandleProps
  L1_2 = 1885233650
  L0_2(L1_2)
  L0_2 = HandleProps
  L1_2 = -1667301416
  L0_2(L1_2)
  L0_2 = L1_1
  L1_2 = 1885233650
  L0_2(L1_2)
  L0_2 = L1_1
  L1_2 = -1667301416
  L0_2(L1_2)
  L0_2 = Wait
  L1_2 = 1000
  L0_2(L1_2)
  while true do
    L0_2 = false
    L1_2 = pairs
    L2_2 = L0_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L0_2 = true
    end
    if not L0_2 then
      L1_2 = ShowInfoDialog
      L2_2 = "pipeline_recalib_done"
      L3_2 = "Recalibration done"
      L4_2 = "Recalibration done! \240\159\142\137 You can now close this window."
      L1_2(L2_2, L3_2, L4_2)
      break
    end
    L1_2 = Wait
    L2_2 = 100
    L1_2(L2_2)
  end
end
L2_1(L3_1, L4_1)
L2_1 = AddEventHandler
L3_1 = "onResourceStop"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = pairs
    L2_2 = L0_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = DeleteEntity
      L8_2 = L6_2
      L7_2(L8_2)
    end
  end
end
L2_1(L3_1, L4_1)
function L2_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = {}
  L5_2 = IterateOverVariations
  L6_2 = A0_2
  L7_2 = A2_2
  L8_2 = 0
  L9_2 = 0
  function L10_2(A0_3, A1_3, A2_3, A3_3)
    local L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3
    L4_3 = print
    L5_3 = "Processing"
    L6_3 = A1_3
    L7_3 = A2_3
    L4_3(L5_3, L6_3, L7_3)
    L4_3 = GetHashNameForComponent
    L5_3 = A0_2
    L6_3 = A1_3
    L7_3 = A2_3
    L8_3 = A3_3
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3)
    L5_3 = GetShopPedComponent
    L6_3 = L4_3
    L5_3 = L5_3(L6_3)
    L6_3 = GetDecalVariations
    L7_3 = A3_2
    L8_3 = A0_2
    L9_3 = L4_3
    L6_3 = L6_3(L7_3, L8_3, L9_3)
    L7_3 = GetForcedComponents
    L8_3 = A0_2
    L9_3 = L4_3
    L7_3 = L7_3(L8_3, L9_3)
    L8_3 = ResolveRecommendedArms
    L9_3 = A0_2
    L10_3 = L7_3
    L8_3 = L8_3(L9_3, L10_3)
    L9_3 = GetPedCollectionNameFromDrawable
    L10_3 = A0_2
    L11_3 = A1_3
    L12_3 = A2_3
    L9_3 = L9_3(L10_3, L11_3, L12_3)
    L10_3 = GetPedCollectionLocalIndexFromDrawable
    L11_3 = A0_2
    L12_3 = A1_3
    L13_3 = A2_3
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    if "" == L9_3 then
      L9_3 = "nondlcgta5"
    end
    if not L9_3 or not L10_3 then
      L11_3 = print
      L12_3 = "No collection name/index for"
      L13_3 = A1_3
      L14_3 = A2_3
      L11_3(L12_3, L13_3, L14_3)
    end
    L11_3 = table
    L11_3 = L11_3.insert
    L12_3 = L4_2
    L13_3 = {}
    L13_3.nameHash = L4_3
    L13_3.componentId = A1_3
    L13_3.drawableId = A2_3
    L13_3.textureId = A3_3
    L14_3 = A1_2
    L13_3.pedModel = L14_3
    L13_3.collectionName = L9_3
    L13_3.collectionIndex = L10_3
    L14_3 = L5_3.Label
    L13_3.labelGxt = L14_3
    L14_3 = GetLabelText
    L15_3 = L5_3.Label
    L14_3 = L14_3(L15_3)
    L13_3.label = L14_3
    L14_3 = ResolvePrice
    L15_3 = L5_3.Price
    L14_3 = L14_3(L15_3)
    L13_3.price = L14_3
    L13_3.recommendedArms = L8_3
    L13_3.setComponents = L7_3
    L11_3(L12_3, L13_3)
    L11_3 = ipairs
    L12_3 = L6_3
    L11_3, L12_3, L13_3, L14_3 = L11_3(L12_3)
    for L15_3, L16_3 in L11_3, L12_3, L13_3, L14_3 do
      L17_3 = table
      L17_3 = L17_3.insert
      L18_3 = L4_2
      L19_3 = {}
      L19_3.nameHash = L4_3
      L19_3.componentId = A1_3
      L19_3.drawableId = A2_3
      L19_3.textureId = A3_3
      L20_3 = A1_2
      L19_3.pedModel = L20_3
      L19_3.collectionName = L9_3
      L19_3.collectionIndex = L10_3
      L20_3 = L16_3.CollectionHash
      L19_3.decalCollectionHash = L20_3
      L20_3 = L16_3.DecorationNameHash
      L19_3.decalNameHash = L20_3
      L20_3 = L16_3.Label
      L19_3.labelGxt = L20_3
      L20_3 = GetLabelText
      L21_3 = L16_3.Label
      L20_3 = L20_3(L21_3)
      L19_3.label = L20_3
      L20_3 = L16_3.Price
      if nil == L20_3 then
        L20_3 = ResolvePrice
        L21_3 = L5_3.Price
        L20_3 = L20_3(L21_3)
        if L20_3 then
          goto lbl_112
        end
      end
      L20_3 = L16_3.Price
      ::lbl_112::
      L19_3.price = L20_3
      L19_3.recommendedArms = L8_3
      L19_3.setComponents = L7_3
      L17_3(L18_3, L19_3)
      L17_3 = L4_2
      L17_3 = #L17_3
      if L17_3 > 40 then
        L17_3 = print
        L18_3 = "Sending to server..."
        L17_3(L18_3)
        L17_3 = TriggerServerEvent
        L18_3 = "rcore_clothing:sendClothingMappingData"
        L19_3 = L4_2
        L17_3(L18_3, L19_3)
        L17_3 = Wait
        L18_3 = 1000
        L17_3(L18_3)
        L17_3 = {}
        L4_2 = L17_3
      end
    end
    L11_3 = L4_2
    L11_3 = #L11_3
    if L11_3 > 40 then
      L11_3 = print
      L12_3 = "Sending to server..."
      L11_3(L12_3)
      L11_3 = TriggerServerEvent
      L12_3 = "rcore_clothing:sendClothingMappingData"
      L13_3 = L4_2
      L11_3(L12_3, L13_3)
      L11_3 = Wait
      L12_3 = 1000
      L11_3(L12_3)
      L11_3 = {}
      L4_2 = L11_3
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = print
  L6_2 = "Sending rest..."
  L5_2(L6_2)
  L5_2 = TriggerServerEvent
  L6_2 = "rcore_clothing:sendClothingMappingData"
  L7_2 = L4_2
  L5_2(L6_2, L7_2)
end
HandleClothingComponent = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = 0
  L3_2 = 1
  L4_2 = 2
  L5_2 = 6
  L6_2 = 7
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L2_2 = {}
  L3_2 = pairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = Wait
    L10_2 = 0
    L9_2(L10_2)
    L9_2 = GetEntityCoords
    L10_2 = PlayerPedId
    L10_2, L11_2 = L10_2()
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = Citizen
    L10_2 = L10_2.CreateThread
    function L11_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
      L0_3 = L9_2
      L1_3 = vector3
      L2_3 = L7_2
      L2_3 = L2_3 / 3
      L3_3 = L7_2
      L3_3 = L3_3 % 3
      L3_3 = L3_3 / 2
      L3_3 = -L3_3
      L3_3 = 2.0 + L3_3
      L4_3 = 1.0
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      L0_3 = L0_3 + L1_3
      L1_3 = CreatePed
      L2_3 = 0
      L3_3 = A0_2
      L4_3 = L0_3
      L5_3 = 0.0
      L6_3 = false
      L7_3 = false
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
      L2_3 = SetBlockingOfNonTemporaryEvents
      L3_3 = L1_3
      L4_3 = true
      L2_3(L3_3, L4_3)
      L2_3 = SetPedHeadBlendData
      L3_3 = L1_3
      L4_3 = 0
      L5_3 = 0
      L6_3 = 0
      L7_3 = 0
      L8_3 = 0
      L9_3 = 0
      L10_3 = 0.0
      L11_3 = 0.0
      L12_3 = 0.0
      L13_3 = false
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
      L3_3 = L8_2
      L2_3 = L2_2
      L4_3 = {}
      L4_3.ped = L1_3
      L4_3.done = false
      L2_3[L3_3] = L4_3
      L2_3 = L0_1
      L2_3[L1_3] = L1_3
      L2_3 = Wait
      L3_3 = 500
      L2_3(L3_3)
      L2_3 = HandlePropsComponent
      L3_3 = L1_3
      L4_3 = A0_2
      L5_3 = L8_2
      L2_3(L3_3, L4_3, L5_3)
      L2_3 = L0_1
      L2_3[L1_3] = nil
      L2_3 = DeletePed
      L3_3 = L1_3
      L2_3(L3_3)
      L3_3 = L8_2
      L2_3 = L2_2
      L2_3 = L2_3[L3_3]
      L2_3.done = true
    end
    L10_2(L11_2)
  end
end
HandleProps = L2_1
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = {}
  L4_2 = IterateOverProps
  L5_2 = A0_2
  L6_2 = A2_2
  L7_2 = 0
  L8_2 = 0
  function L9_2(A0_3, A1_3, A2_3, A3_3)
    local L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L4_3 = print
    L5_3 = "Processing"
    L6_3 = A1_3
    L7_3 = A2_3
    L8_3 = A3_3
    L4_3(L5_3, L6_3, L7_3, L8_3)
    L4_3 = GetHashNameForProp
    L5_3 = A0_2
    L6_3 = A2_2
    L7_3 = A2_3
    L8_3 = A3_3
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3)
    L5_3 = GetShopPedProp
    L6_3 = L4_3
    L5_3 = L5_3(L6_3)
    L6_3 = GetPedCollectionNameFromProp
    L7_3 = A0_2
    L8_3 = A2_2
    L9_3 = A2_3
    L6_3 = L6_3(L7_3, L8_3, L9_3)
    L7_3 = GetPedCollectionLocalIndexFromProp
    L8_3 = A0_2
    L9_3 = A2_2
    L10_3 = A2_3
    L7_3 = L7_3(L8_3, L9_3, L10_3)
    if "" == L6_3 then
      L6_3 = "nondlcgta5"
    end
    L8_3 = table
    L8_3 = L8_3.insert
    L9_3 = L3_2
    L10_3 = {}
    L10_3.nameHash = L4_3
    L11_3 = A2_2
    L11_3 = 100 + L11_3
    L10_3.componentId = L11_3
    L10_3.drawableId = A2_3
    L10_3.textureId = A3_3
    L11_3 = A1_2
    L10_3.pedModel = L11_3
    L10_3.collectionName = L6_3
    L10_3.collectionIndex = L7_3
    L11_3 = L5_3.Label
    L10_3.labelGxt = L11_3
    L11_3 = GetLabelText
    L12_3 = L5_3.Label
    L11_3 = L11_3(L12_3)
    L10_3.label = L11_3
    L11_3 = ResolvePrice
    L12_3 = L5_3.Price
    L11_3 = L11_3(L12_3)
    L10_3.price = L11_3
    L8_3(L9_3, L10_3)
    L8_3 = L3_2
    L8_3 = #L8_3
    if L8_3 > 40 then
      L8_3 = print
      L9_3 = "Sending to server..."
      L8_3(L9_3)
      L8_3 = TriggerServerEvent
      L9_3 = "rcore_clothing:sendPropMappingData"
      L10_3 = L3_2
      L8_3(L9_3, L10_3)
      L8_3 = Wait
      L9_3 = 1000
      L8_3(L9_3)
      L8_3 = {}
      L3_2 = L8_3
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = print
  L5_2 = "Sending rest..."
  L4_2(L5_2)
  L4_2 = TriggerServerEvent
  L5_2 = "rcore_clothing:sendPropMappingData"
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
end
HandlePropsComponent = L2_1
function L2_1(A0_2)
  local L1_2, L2_2
  if A0_2 and "" ~= A0_2 then
    L1_2 = GetLabelText
    L2_2 = A0_2
    return L1_2(L2_2)
  end
  L1_2 = nil
  return L1_2
end
ResolveLabel = L2_1
function L2_1(A0_2)
  local L1_2
  if A0_2 and A0_2 > 0 then
    return A0_2
  end
  L1_2 = nil
  return L1_2
end
ResolvePrice = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L2_2 = 3
  L3_2 = ipairs
  L4_2 = A1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L8_2.componentId
    if L9_2 == L2_2 then
      L9_2 = L8_2.nameHash
      L10_2 = L8_2.drawableId
      L11_2 = L8_2.textureId
      L12_2 = GetShopPedComponent
      L13_2 = L9_2
      L12_2 = L12_2(L13_2)
      L13_2 = GetUsableHash
      L14_2 = 3
      L15_2 = L10_2
      L16_2 = L11_2
      L17_2 = L12_2.Hash
      return L13_2(L14_2, L15_2, L16_2, L17_2)
    end
  end
  L3_2 = nil
  return L3_2
end
ResolveRecommendedArms = L2_1
