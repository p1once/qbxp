local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = 0
L1_1 = {}
L2_1 = nil
L3_1 = RegisterNetEvent
L4_1 = "rcore_clothing:queryShopResponse"
function L5_1(A0_2, A1_2)
  local L2_2
  L2_2 = L1_1
  L2_2[A0_2] = A1_2
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "rcore_clothing:checkoutResult"
function L5_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2
  L4_2 = L1_1
  L5_2 = {}
  L5_2.result = A1_2
  L5_2.moneyMissing = A3_2
  L5_2.purchased = A2_2
  L4_2[A0_2] = L5_2
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "rcore_clothing:headModResult"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L1_1
  L3_2 = {}
  L3_2.result = A1_2
  L2_2[A0_2] = L3_2
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "rcore_clothing:setPedModelResult"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L1_1
  L3_2 = {}
  L3_2.result = A1_2
  L2_2[A0_2] = L3_2
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "rcore_clothing:setPersonalOutfits"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L1_1
  L3_2 = {}
  L3_2.result = A1_2
  L2_2[A0_2] = L3_2
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "rcore_clothing:setShopOutfits"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L1_1
  L3_2 = {}
  L3_2.result = A1_2
  L2_2[A0_2] = L3_2
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNUICallback
L4_1 = "getCurrentPedData"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = GetShopPed
  L2_2 = L2_2()
  L3_2 = GetCurrentPedData
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = A1_2
  L5_2 = L3_2
  L4_2(L5_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNUICallback
L4_1 = "close"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = GetCurrentShopConfig
  L2_2 = L2_2()
  if A0_2 then
    L3_2 = A0_2.forceClose
    if L3_2 then
      goto lbl_9
    end
  end
  L3_2 = false
  ::lbl_9::
  L4_2 = StopImageDebug
  L4_2()
  if not L3_2 and L2_2 then
    L4_2 = L2_2.modifiers
    if L4_2 then
      L4_2 = L2_2.modifiers
      L5_2 = SHOP_MODIFIERS
      L5_2 = L5_2.CAN_NOT_BE_CLOSED
      L4_2 = L4_2[L5_2]
      if L4_2 then
    end
  end
  else
    L4_2 = SOUNDS_BY_TYPE
    L4_2 = L4_2.QUIT_UI
    L5_2 = PlaySoundFrontend
    L6_2 = -1
    L7_2 = L4_2.name
    L8_2 = L4_2.soundset
    L9_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = CloseNUI
    L5_2()
    L5_2 = StartRenderingMarkers
    L5_2()
  end
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNUICallback
L4_1 = "onInfoDialogConfirm"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = GetIsNuiOpen
  L2_2 = L2_2()
  if not L2_2 then
    L2_2 = SetNUIFocus
    L3_2 = false
    L2_2(L3_2)
  end
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L3_1(L4_1, L5_1)
L3_1 = RegisterNetEvent
L4_1 = "rcore_clothing:setShopBaseStructure"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = SendReactMessage
  L3_2 = "setMenuData"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = SendReactMessage
  L3_2 = "setClothingCategories"
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
L3_1(L4_1, L5_1)
L3_1 = 0
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = 10
  L3_2 = pairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = ResolveItemToClothingOrPropItem
    L10_2 = GetShopPed
    L10_2 = L10_2()
    L11_2 = L8_2
    L9_2 = L9_2(L10_2, L11_2)
    L1_2[L7_2] = L8_2
    L10_2 = L1_2[L7_2]
    L11_2 = L9_2.drawableId
    L10_2.drawable_id = L11_2
    L10_2 = L1_2[L7_2]
    L11_2 = L9_2.textureId
    L10_2.texture_id = L11_2
    L2_2 = L2_2 - 1
    if L2_2 <= 0 then
      L10_2 = Wait
      L11_2 = 0
      L10_2(L11_2)
      L2_2 = 10
    end
  end
  return L1_2
end
L5_1 = RegisterNUICallback
L6_1 = "fetchItems"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L2_2 = A0_2.shopType
  L3_2 = A0_2.componentId
  L4_2 = A0_2.lastId
  L5_2 = A0_2.category
  L6_2 = A0_2.colors
  L7_2 = A0_2.searchQuery
  L8_2 = A0_2.fetchAllItems
  L9_2 = A0_2.groupByDrawable
  L10_2 = A0_2.onlyAddons
  L11_2 = A0_2.notInAnyShop
  L12_2 = A0_2.isFirstFetch
  L13_2 = L0_1
  L13_2 = L13_2 + 1
  L0_1 = L13_2
  L13_2 = L0_1
  L14_2 = L3_1
  L14_2 = L14_2 + 1
  L3_1 = L14_2
  L14_2 = Citizen
  L14_2 = L14_2.SetTimeout
  L15_2 = 3000
  function L16_2()
    local L0_3, L1_3
    L0_3 = L3_1
    L0_3 = L0_3 - 1
    L3_1 = L0_3
  end
  L14_2(L15_2, L16_2)
  L14_2 = L3_1
  if L14_2 > 10 then
    L14_2 = A1_2
    L15_2 = {}
    L15_2.rateLimit = true
    L14_2(L15_2)
    return
  end
  L14_2 = QueryBackend
  L15_2 = L2_2
  L16_2 = L13_2
  L17_2 = L3_2
  L18_2 = L5_2
  L19_2 = L6_2
  L20_2 = L7_2
  L21_2 = L4_2
  L22_2 = L8_2
  L23_2 = L9_2
  L24_2 = L10_2
  L25_2 = L11_2
  L26_2 = L12_2
  L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L14_2 = AwaitAsyncResponse
  L15_2 = L13_2
  L14_2 = L14_2(L15_2)
  L15_2 = L14_2.timeout
  if L15_2 then
    L15_2 = A1_2
    L16_2 = {}
    L16_2.timeout = true
    L15_2(L16_2)
    return
  end
  if "ratelimited" == L14_2 then
    L15_2 = A1_2
    L16_2 = {}
    L16_2.rateLimit = true
    L15_2(L16_2)
    return
  end
  L15_2 = L4_1
  L16_2 = L14_2
  L15_2 = L15_2(L16_2)
  L16_2 = A1_2
  L17_2 = {}
  L17_2.items = L15_2
  L16_2(L17_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "resolveExternalItems"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L4_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = A1_2
  L4_2 = {}
  L4_2.items = L2_2
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
function L5_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = GetGameTimer
  L1_2 = L1_2()
  L1_2 = L1_2 + 3000
  while true do
    L2_2 = L1_1
    L2_2 = L2_2[A0_2]
    if L2_2 then
      break
    end
    L2_2 = GetGameTimer
    L2_2 = L2_2()
    if L1_2 < L2_2 then
      L2_2 = print
      L3_2 = "Request timed out"
      L2_2(L3_2)
      L2_2 = {}
      L2_2.timeout = true
      return L2_2
    end
    L2_2 = Wait
    L3_2 = 0
    L2_2(L3_2)
  end
  L2_2 = L1_1
  L2_2 = L2_2[A0_2]
  L3_2 = L1_1
  L3_2[A0_2] = nil
  return L2_2
end
AwaitAsyncResponse = L5_1
L5_1 = RegisterNUICallback
L6_1 = "previewItem"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.item
  L3_2 = IsDebuggingImages
  L3_2 = L3_2()
  if L3_2 then
    L3_2 = InvisibilityMakeInvisible
    L4_2 = GetEntityModel
    L5_2 = PlayerPedId
    L5_2 = L5_2()
    L4_2, L5_2 = L4_2(L5_2)
    L3_2(L4_2, L5_2)
  end
  L3_2 = AnimResolveAndPlayPurchaseAnim
  L4_2 = PlayerPedId
  L4_2 = L4_2()
  L5_2 = L2_2.component_id
  L3_2(L4_2, L5_2)
  L3_2 = ApplyPedClothingItem
  L4_2 = PlayerPedId
  L4_2 = L4_2()
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewNonFreemodeHead"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A0_2.values
  L2_2 = L2_2.number
  L3_2 = A0_2.values
  L3_2 = L3_2.number_2
  L4_2 = SetPedComponentVariation
  L5_2 = PlayerPedId
  L5_2 = L5_2()
  L6_2 = 0
  L7_2 = L2_2
  L8_2 = L3_2
  L9_2 = 2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewHeadBlend"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2.maleModel
  L3_2 = A0_2.femaleModel
  L4_2 = A0_2.modelBlend
  if not L4_2 then
    L4_2 = 0
  end
  L4_2 = L4_2 + 0.0
  L5_2 = A0_2.maleTone
  L6_2 = A0_2.femaleTone
  L7_2 = A0_2.toneBlend
  if not L7_2 then
    L7_2 = 0
  end
  L7_2 = L7_2 + 0.0
  L8_2 = ShopHeadblendPreview
  L9_2 = L2_2
  L10_2 = L3_2
  L11_2 = L4_2
  L12_2 = L5_2
  L13_2 = L6_2
  L14_2 = L7_2
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = A1_2
  L9_2 = "ok"
  L8_2(L9_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewHeadOverlay"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = A0_2.headOverlayId
  L3_2 = A0_2.values
  L4_2 = L3_2.number
  L5_2 = L3_2.size
  L5_2 = L5_2 / 10.0
  L6_2 = tonumber
  L7_2 = L3_2.color
  if not L7_2 then
    L7_2 = 0
  end
  L6_2 = L6_2(L7_2)
  L7_2 = tonumber
  L8_2 = L3_2.color_2
  if not L8_2 then
    L8_2 = 0
  end
  L7_2 = L7_2(L8_2)
  L8_2 = ShopHeadOverlayPreview
  L9_2 = L2_2
  L10_2 = L4_2
  L11_2 = L5_2
  L12_2 = L6_2
  L13_2 = L7_2
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  L8_2 = A1_2
  L9_2 = "ok"
  L8_2(L9_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewHair"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = A0_2.values
  L3_2 = L2_2.number
  L4_2 = tonumber
  L5_2 = L2_2.color
  if not L5_2 then
    L5_2 = 0
  end
  L4_2 = L4_2(L5_2)
  L5_2 = tonumber
  L6_2 = L2_2.color_2
  if not L6_2 then
    L6_2 = 0
  end
  L5_2 = L5_2(L6_2)
  L6_2 = UsableHashToData
  L7_2 = GetShopPed
  L7_2 = L7_2()
  L8_2 = L3_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = ShopHairPreview
  L8_2 = L6_2.drawableId
  L9_2 = L4_2
  L10_2 = L5_2
  L11_2 = L6_2.textureId
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = A1_2
  L8_2 = "ok"
  L7_2(L8_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewEyeColor"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = A0_2.values
  L3_2 = tonumber
  L4_2 = L2_2.type_eye_color
  if not L4_2 then
    L4_2 = 0
  end
  L3_2 = L3_2(L4_2)
  L4_2 = ShopEyeColorPreview
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "confirmHeadBlend"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = A0_2.maleModel
  L3_2 = A0_2.femaleModel
  L4_2 = A0_2.modelBlend
  if not L4_2 then
    L4_2 = 0
  end
  L4_2 = L4_2 + 0.0
  L5_2 = A0_2.maleTone
  L6_2 = A0_2.femaleTone
  L7_2 = A0_2.toneBlend
  if not L7_2 then
    L7_2 = 0
  end
  L7_2 = L7_2 + 0.0
  L8_2 = A0_2.paymentType
  L9_2 = L0_1
  L9_2 = L9_2 + 1
  L0_1 = L9_2
  L9_2 = L0_1
  L10_2 = TriggerServerEvent
  L11_2 = "rcore_clothing:attemptHeadMod"
  L12_2 = L9_2
  L13_2 = SHOP_STRUCTURE
  L13_2 = L13_2.CHAR_HEADBLEND
  L14_2 = {}
  L14_2.maleModel = L2_2
  L14_2.femaleModel = L3_2
  L14_2.modelBlend = L4_2
  L14_2.maleTone = L5_2
  L14_2.femaleTone = L6_2
  L14_2.toneBlend = L7_2
  L15_2 = L8_2
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
  L10_2 = AwaitAsyncResponse
  L11_2 = L9_2
  L10_2 = L10_2(L11_2)
  L11_2 = L10_2.result
  if L11_2 then
    L11_2 = ShopConfirmHeadblend
    L11_2()
    L11_2 = SendCurrentPedDataNUI
    L11_2()
    L11_2 = A1_2
    L12_2 = "ok"
    L11_2(L12_2)
  else
    L11_2 = A1_2
    L12_2 = false
    L11_2(L12_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "confirmHeadOverlay"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = A0_2.headOverlayId
  L3_2 = A0_2.values
  L4_2 = A0_2.paymentType
  L5_2 = L3_2.number
  L6_2 = L3_2.size
  L6_2 = L6_2 / 10.0
  L7_2 = tonumber
  L8_2 = L3_2.color
  if not L8_2 then
    L8_2 = 0
  end
  L7_2 = L7_2(L8_2)
  L8_2 = tonumber
  L9_2 = L3_2.color_2
  if not L9_2 then
    L9_2 = 0
  end
  L8_2 = L8_2(L9_2)
  L9_2 = L0_1
  L9_2 = L9_2 + 1
  L0_1 = L9_2
  L9_2 = L0_1
  L10_2 = TriggerServerEvent
  L11_2 = "rcore_clothing:attemptHeadMod"
  L12_2 = L9_2
  L13_2 = "headOverlay"
  L14_2 = {}
  L14_2.overlayId = L2_2
  L14_2.id = L5_2
  L14_2.opacity = L6_2
  L14_2.color1 = L7_2
  L14_2.color2 = L8_2
  L15_2 = L4_2
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
  L10_2 = AwaitAsyncResponse
  L11_2 = L9_2
  L10_2 = L10_2(L11_2)
  L11_2 = L10_2.result
  if L11_2 then
    L11_2 = ShopConfirmHeadOverlay
    L11_2()
    L11_2 = SendCurrentPedDataNUI
    L11_2()
    L11_2 = A1_2
    L12_2 = "ok"
    L11_2(L12_2)
  else
    L11_2 = A1_2
    L12_2 = false
    L11_2(L12_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "confirmHair"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = A0_2.values
  L3_2 = L2_2.number
  L4_2 = tonumber
  L5_2 = L2_2.color
  if not L5_2 then
    L5_2 = 0
  end
  L4_2 = L4_2(L5_2)
  L5_2 = tonumber
  L6_2 = L2_2.color_2
  if not L6_2 then
    L6_2 = 0
  end
  L5_2 = L5_2(L6_2)
  L6_2 = A0_2.paymentType
  L7_2 = L0_1
  L7_2 = L7_2 + 1
  L0_1 = L7_2
  L7_2 = L0_1
  L8_2 = TriggerServerEvent
  L9_2 = "rcore_clothing:attemptHeadMod"
  L10_2 = L7_2
  L11_2 = SHOP_STRUCTURE
  L11_2 = L11_2.HAIR_HAIR
  L12_2 = {}
  L12_2.id = L3_2
  L12_2.color1 = L4_2
  L12_2.color2 = L5_2
  L13_2 = L6_2
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  L8_2 = AwaitAsyncResponse
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  L9_2 = L8_2.result
  if L9_2 then
    L9_2 = ShopConfirmHair
    L9_2()
    L9_2 = SendCurrentPedDataNUI
    L9_2()
    L9_2 = A1_2
    L10_2 = "ok"
    L9_2(L10_2)
  else
    L9_2 = A1_2
    L10_2 = false
    L9_2(L10_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "confirmEyeColor"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = A0_2.values
  L3_2 = tonumber
  L4_2 = L2_2.type_eye_color
  if not L4_2 then
    L4_2 = 0
  end
  L3_2 = L3_2(L4_2)
  L4_2 = A0_2.paymentType
  L5_2 = L0_1
  L5_2 = L5_2 + 1
  L0_1 = L5_2
  L5_2 = L0_1
  L6_2 = TriggerServerEvent
  L7_2 = "rcore_clothing:attemptHeadMod"
  L8_2 = L5_2
  L9_2 = SHOP_STRUCTURE
  L9_2 = L9_2.CHAR_EYE_COLOR
  L10_2 = {}
  L10_2.id = L3_2
  L11_2 = L4_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = AwaitAsyncResponse
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  L7_2 = L6_2.result
  if L7_2 then
    L7_2 = ShopConfirmEyeColor
    L7_2()
    L7_2 = SendCurrentPedDataNUI
    L7_2()
    L7_2 = A1_2
    L8_2 = "ok"
    L7_2(L8_2)
  else
    L7_2 = A1_2
    L8_2 = false
    L7_2(L8_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "confirmFaceFeaturse"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = A0_2.values
  L3_2 = A0_2.paymentType
  L4_2 = L0_1
  L4_2 = L4_2 + 1
  L0_1 = L4_2
  L4_2 = L0_1
  L5_2 = TriggerServerEvent
  L6_2 = "rcore_clothing:attemptHeadMod"
  L7_2 = L4_2
  L8_2 = SHOP_STRUCTURE
  L8_2 = L8_2.CHAR_FACE_FEATURES
  L9_2 = {}
  L9_2.values = L2_2
  L10_2 = L3_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = AwaitAsyncResponse
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2.result
  if L6_2 then
    L6_2 = ShopConfirmFaceFeatures
    L6_2()
    L6_2 = SendCurrentPedDataNUI
    L6_2()
    L6_2 = A1_2
    L7_2 = "ok"
    L6_2(L7_2)
  else
    L6_2 = A1_2
    L7_2 = false
    L6_2(L7_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "confirmPed"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2.ped
  L3_2 = A0_2.paymentType
  L4_2 = {}
  L5_2 = 0
  L6_2 = 11
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = GetPedDrawableVariation
    L10_2 = PlayerPedId
    L10_2 = L10_2()
    L11_2 = L8_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = GetPedTextureVariation
    L11_2 = PlayerPedId
    L11_2 = L11_2()
    L12_2 = L8_2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = GetUsableHash
    L12_2 = L8_2
    L13_2 = L9_2
    L14_2 = L10_2
    L11_2 = L11_2(L12_2, L13_2, L14_2)
    L4_2[L8_2] = L11_2
  end
  L5_2 = L0_1
  L5_2 = L5_2 + 1
  L0_1 = L5_2
  L5_2 = GetDefaultHeadblend
  L6_2 = L2_2
  L5_2 = L5_2(L6_2)
  L6_2 = L0_1
  L7_2 = TriggerServerEvent
  L8_2 = "rcore_clothing:setPedModel"
  L9_2 = L6_2
  L10_2 = L2_2
  L11_2 = L4_2
  L12_2 = L5_2
  L13_2 = L3_2
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = AwaitAsyncResponse
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  L8_2 = L7_2.result
  if L8_2 then
    L8_2 = ShopConfirmPedModel
    L8_2()
    L8_2 = SendCurrentPedDataNUI
    L8_2()
    L8_2 = AnimSetPedStill
    L9_2 = PlayerPedId
    L9_2 = L9_2()
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = A1_2
    L9_2 = "ok"
    L8_2(L9_2)
  else
    L8_2 = A1_2
    L9_2 = false
    L8_2(L9_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "confirmHead"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = GetUsableHash
  L3_2 = 0
  L4_2 = A0_2.values
  L4_2 = L4_2.number
  L5_2 = A0_2.values
  L5_2 = L5_2.number_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = A0_2.paymentType
  L4_2 = L0_1
  L4_2 = L4_2 + 1
  L0_1 = L4_2
  L4_2 = L0_1
  L5_2 = TriggerServerEvent
  L6_2 = "rcore_clothing:attemptHeadMod"
  L7_2 = L4_2
  L8_2 = SHOP_STRUCTURE
  L8_2 = L8_2.CHAR_NONFREEMODE_HEAD
  L9_2 = {}
  L9_2.values = L2_2
  L10_2 = L3_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = AwaitAsyncResponse
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = L5_2.result
  if L6_2 then
    L6_2 = ShopConfirmHead
    L6_2()
    L6_2 = SendCurrentPedDataNUI
    L6_2()
    L6_2 = A1_2
    L7_2 = "ok"
    L6_2(L7_2)
  else
    L6_2 = A1_2
    L7_2 = false
    L6_2(L7_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "resetKeepCart"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = ResetEverything
  L2_2()
  L2_2 = pairs
  L3_2 = A0_2.items
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ApplyPedClothingItem
    L9_2 = PlayerPedId
    L9_2 = L9_2()
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
  end
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "resetComponents"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = A0_2.componentIds
  L2_2 = #L2_2
  if L2_2 then
    L2_2 = ResetComponent
    L3_2 = A0_2.componentIds
    L2_2(L3_2)
  end
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "resetAllComponents"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = ResetEverything
  L2_2()
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "requestCompleteMenuData"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = RequestFullShopStructureExceptHead
  L2_2()
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "refreshMenuData"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = A0_2.shopType
  if not L2_2 then
    return
  end
  L2_2 = RefreshClothingShop
  L3_2 = A0_2.shopType
  L2_2(L3_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "toggleItemStock"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A0_2.id
  L3_2 = A0_2.addToStock
  L4_2 = A0_2.shopType
  L5_2 = A0_2.groupByDrawable
  if L5_2 then
    if L3_2 then
      L6_2 = TriggerServerEvent
      L7_2 = "rcore_clothing:addGroupToShop"
      L8_2 = L2_2
      L9_2 = L4_2
      L6_2(L7_2, L8_2, L9_2)
    else
      L6_2 = TriggerServerEvent
      L7_2 = "rcore_clothing:removeGroupFromShop"
      L8_2 = L2_2
      L9_2 = L4_2
      L6_2(L7_2, L8_2, L9_2)
    end
  elseif L3_2 then
    L6_2 = TriggerServerEvent
    L7_2 = "rcore_clothing:addItemToShop"
    L8_2 = L2_2
    L9_2 = L4_2
    L6_2(L7_2, L8_2, L9_2)
  else
    L6_2 = TriggerServerEvent
    L7_2 = "rcore_clothing:removeItemFromShop"
    L8_2 = L2_2
    L9_2 = L4_2
    L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = A1_2
  L7_2 = "ok"
  L6_2(L7_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "editItemMetadata"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L2_2 = A0_2.id
  L3_2 = A0_2.label
  L4_2 = A0_2.price
  L5_2 = A0_2.category
  L6_2 = A0_2.colors
  L7_2 = A0_2.isBlacklisted
  L8_2 = A0_2.jobs
  L9_2 = A0_2.identifiers
  L10_2 = A0_2.groupByDrawable
  L11_2 = A0_2.resetImg
  if L10_2 then
    L12_2 = TriggerServerEvent
    L13_2 = "rcore_clothing:editGroupMetadata"
    L14_2 = L2_2
    L15_2 = L4_2
    L16_2 = L5_2
    L17_2 = L7_2
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2)
  else
    L12_2 = TriggerServerEvent
    L13_2 = "rcore_clothing:editItemMetadata"
    L14_2 = L2_2
    L15_2 = L3_2
    L16_2 = L4_2
    L17_2 = L5_2
    L18_2 = L6_2
    L19_2 = L7_2
    L20_2 = L8_2
    L21_2 = L9_2
    L22_2 = L11_2
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  end
  L12_2 = A1_2
  L13_2 = "ok"
  L12_2(L13_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewFaceFeature"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = ShopFaceFeaturePreview
  L3_2 = A0_2.faceFeatureId
  L4_2 = A0_2.value
  L4_2 = L4_2 + 0.0
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewPed"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.ped
  L3_2 = ShopPreviewPedModel
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "onComponentChange"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = A0_2.componentId
  L4_2 = A0_2.characterSettingsId
  L5_2 = A0_2.pedModel
  if not L5_2 then
    L5_2 = GetEntityModel
    L6_2 = L2_2
    L5_2 = L5_2(L6_2)
  end
  if -1 == L3_2 then
    L6_2 = ClothingCamTransitionToComponent
    L7_2 = L2_2
    L8_2 = CAM_OFFSETS_CLOTHING_SHOP
    L9_2 = 11
    L6_2(L7_2, L8_2, L9_2)
  elseif "headOverlay_10" == L4_2 or "headOverlay_11" == L4_2 then
    L6_2 = ClothingCamTransitionToComponent
    L7_2 = L2_2
    L8_2 = CAM_OFFSETS_CLOTHING_SHOP
    L9_2 = 7
    L6_2(L7_2, L8_2, L9_2)
  elseif "eye_color" == L4_2 then
    L6_2 = ClothingCamTransitionToComponent
    L7_2 = L2_2
    L8_2 = CAM_OFFSETS_CLOTHING_SHOP
    L9_2 = 518
    L6_2(L7_2, L8_2, L9_2)
  else
    L6_2 = ClothingCamTransitionToComponent
    L7_2 = L2_2
    L8_2 = CAM_OFFSETS_CLOTHING_SHOP
    L9_2 = L3_2
    L6_2(L7_2, L8_2, L9_2)
  end
  L6_2 = GetEmptyItemsForCategoryId
  L7_2 = L4_2
  L8_2 = L5_2
  L6_2 = L6_2(L7_2, L8_2)
  if L6_2 then
    L7_2 = Wait
    L8_2 = 0
    L7_2(L8_2)
    L7_2 = pairs
    L8_2 = L6_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = ApplyPedClothingItem
      L14_2 = L2_2
      L15_2 = L12_2
      L13_2(L14_2, L15_2)
    end
    L7_2 = Wait
    L8_2 = 0
    L7_2(L8_2)
    L7_2 = pairs
    L8_2 = L6_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = ApplyPedClothingItem
      L14_2 = L2_2
      L15_2 = L12_2
      L13_2(L14_2, L15_2)
    end
  end
  L7_2 = AnimateEntityRotation
  L8_2 = L2_1
  L7_2(L8_2)
  L7_2 = A1_2
  L8_2 = "ok"
  L7_2(L8_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "attemptCheckout"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L2_2 = A0_2.type
  L3_2 = A0_2.items
  L4_2 = A0_2.outfitName
  L5_2 = A0_2.shopName
  L6_2 = {}
  L7_2 = {}
  L8_2 = pairs
  L9_2 = L3_2
  L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
  for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
    L14_2 = L13_2.component_id
    if 3 == L14_2 then
    else
      L14_2 = L13_2.isUnset
      if L14_2 then
        L14_2 = L13_2.component_id
        if L14_2 >= 100 then
          L14_2 = L6_2.shoplessProp
          if not L14_2 then
            L14_2 = {}
            L6_2.shoplessProp = L14_2
          end
          L14_2 = L6_2.shoplessProp
          L15_2 = L13_2.component_id
          L15_2 = L15_2 - 100
          L16_2 = L13_2.name_hash
          L14_2[L15_2] = L16_2
        else
          L14_2 = L6_2.shoplessComponent
          if not L14_2 then
            L14_2 = {}
            L6_2.shoplessComponent = L14_2
          end
          L14_2 = L6_2.shoplessComponent
          L15_2 = L13_2.component_id
          L16_2 = L13_2.name_hash
          L14_2[L15_2] = L16_2
        end
      else
        L14_2 = table
        L14_2 = L14_2.insert
        L15_2 = L7_2
        L16_2 = L13_2.id
        L14_2(L15_2, L16_2)
      end
    end
  end
  L8_2 = GetComponentUsableHash
  L9_2 = GetShopPed
  L9_2 = L9_2()
  L10_2 = 3
  L8_2 = L8_2(L9_2, L10_2)
  L6_2.arms = L8_2
  L8_2 = L0_1
  L8_2 = L8_2 + 1
  L0_1 = L8_2
  L8_2 = L0_1
  L9_2 = TriggerServerEvent
  L10_2 = "rcore_clothing:attemptCheckout"
  L11_2 = L8_2
  L12_2 = L5_2
  L13_2 = L2_2
  L14_2 = L7_2
  L15_2 = L6_2
  L16_2 = GetCurrentShopConfig
  L16_2, L17_2, L18_2 = L16_2()
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L9_2 = AwaitAsyncResponse
  L10_2 = L8_2
  L9_2 = L9_2(L10_2)
  L10_2 = L9_2.result
  if L10_2 then
    L10_2 = ShopSetComponentPurchasedByHash
    L11_2 = L9_2.purchased
    L10_2(L11_2)
    L10_2 = L6_2.arms
    if L10_2 then
      L10_2 = ShopSetComponentByHash
      L11_2 = 3
      L12_2 = L6_2.arms
      L10_2(L11_2, L12_2)
    end
    L10_2 = L6_2.shoplessComponent
    if L10_2 then
      L10_2 = pairs
      L11_2 = L6_2.shoplessComponent
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
        L16_2 = ShopSetComponentByHash
        L17_2 = L14_2
        L18_2 = L15_2
        L16_2(L17_2, L18_2)
      end
    end
    L10_2 = L6_2.shoplessProp
    if L10_2 then
      L10_2 = pairs
      L11_2 = L6_2.shoplessProp
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
        L16_2 = ShopSetPropByHash
        L17_2 = L14_2
        L18_2 = L15_2
        L16_2(L17_2, L18_2)
      end
    end
    if L4_2 then
      L10_2 = string
      L10_2 = L10_2.len
      L11_2 = L4_2
      L10_2 = L10_2(L11_2)
      if L10_2 > 0 then
        L10_2 = SaveCurrentAsOutfit
        L11_2 = L4_2
        L10_2(L11_2)
      end
    end
  end
  L10_2 = A1_2
  L11_2 = "ok"
  L10_2(L11_2)
  L10_2 = SendReactMessage
  L11_2 = "checkoutResult"
  L12_2 = L9_2.result
  L10_2(L11_2, L12_2)
  L10_2 = L9_2.result
  if L10_2 then
    L10_2 = SendCurrentPedDataNUI
    L10_2()
    if "CHARCREATOR" == L5_2 then
      L10_2 = TriggerEvent
      L11_2 = "rcore_clothing:charcreator:done"
      L10_2(L11_2)
      L10_2 = TriggerServerEvent
      L11_2 = "rcore_clothing:charcreator:done"
      L10_2(L11_2)
      L10_2 = SaveCurrentAsOutfit
      L11_2 = _U
      L12_2 = "outfits.default_outfit"
      L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L11_2(L12_2)
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L10_2 = ESXSetIsCreatingChar
      L11_2 = false
      L10_2(L11_2)
    end
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "saveOutfit"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.outfitName
  L3_2 = SaveCurrentAsOutfit
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "saveShopOutfit"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = A0_2.id
  L3_2 = A0_2.name
  L4_2 = A0_2.price
  L5_2 = A0_2.jobs
  L6_2 = A0_2.identifiers
  L7_2 = A0_2.shopName
  if L2_2 then
    L8_2 = string
    L8_2 = L8_2.len
    L9_2 = L2_2
    L8_2 = L8_2(L9_2)
    if 0 ~= L8_2 then
      goto lbl_23
    end
  end
  L8_2 = SaveCurrentAsShopOutfit
  L9_2 = L3_2
  L10_2 = L7_2
  L11_2 = L4_2
  L12_2 = L5_2
  L13_2 = L6_2
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  goto lbl_31
  ::lbl_23::
  L8_2 = TriggerServerEvent
  L9_2 = "rcore_clothing:editShopOutfit"
  L10_2 = L2_2
  L11_2 = L3_2
  L12_2 = L4_2
  L13_2 = L5_2
  L14_2 = L6_2
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  ::lbl_31::
  L8_2 = A1_2
  L9_2 = "ok"
  L8_2(L9_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "previewOutfit"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = json
  L2_2 = L2_2.decode
  L3_2 = A0_2.outfit
  L2_2 = L2_2(L3_2)
  L3_2 = ShopPreviewOutfit
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "selectOutfit"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = json
  L2_2 = L2_2.decode
  L3_2 = A0_2.outfit
  L2_2 = L2_2(L3_2)
  L3_2 = ShopPreviewOutfit
  L4_2 = L2_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = TriggerEvent
  L4_2 = "rcore_clothing:saveCurrentSkin"
  L3_2(L4_2)
  L3_2 = TriggerEvent
  L4_2 = "rcore_clothing:outfitChanged"
  L3_2(L4_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "removeOutfit"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = A0_2.id
  L3_2 = A0_2.type
  if "my_outfits" == L3_2 then
    L4_2 = TriggerServerEvent
    L5_2 = "rcore_clothing:removePersonalOutfit"
    L6_2 = L2_2
    L4_2(L5_2, L6_2)
  else
    L4_2 = TriggerServerEvent
    L5_2 = "rcore_clothing:removeShopOutfit"
    L6_2 = L2_2
    L4_2(L5_2, L6_2)
  end
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "buyOutfit"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2.id
  L3_2 = json
  L3_2 = L3_2.decode
  L4_2 = A0_2.outfit
  L3_2 = L3_2(L4_2)
  L4_2 = TriggerServerEvent
  L5_2 = "rcore_clothing:buyOutfit"
  L6_2 = L2_2
  L7_2 = L3_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = SendCurrentPedDataNUI
  L4_2()
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNetEvent
L6_1 = "rcore_clothing:outfitBought"
function L7_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = ShopPreviewOutfit
  L2_2 = A0_2
  L3_2 = true
  L1_2(L2_2, L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "getOutfits"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = A0_2.type
  L3_2 = A0_2.shopName
  if "my_outfits" == L2_2 then
    L4_2 = GetPersonalOutfits
    L4_2 = L4_2()
    L5_2 = A1_2
    L6_2 = L4_2
    L5_2(L6_2)
    return
  elseif "global_outfits" == L2_2 and L3_2 then
    L4_2 = string
    L4_2 = L4_2.len
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if L4_2 > 0 then
      L4_2 = GetShopOutfits
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      L5_2 = A1_2
      L6_2 = L4_2
      L5_2(L6_2)
      return
    end
  end
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "playSound"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = SOUNDS_BY_TYPE
  L2_2 = L2_2[A0_2]
  if L2_2 then
    L3_2 = PlaySoundFrontend
    L4_2 = -1
    L5_2 = L2_2.name
    L6_2 = L2_2.soundset
    L7_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "getNumbersOnlyData"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = A0_2.componentId
  L3_2 = A0_2.shopName
  L4_2 = PlayerPedId
  L4_2 = L4_2()
  L5_2 = {}
  L5_2.minDrawable = 0
  L5_2.maxDrawable = nil
  L5_2.minTexture = 0
  L5_2.maxTexture = nil
  L5_2.currentDrawable = nil
  L5_2.currentTexture = nil
  if L2_2 < 100 then
    L6_2 = GetNumberOfPedDrawableVariations
    L7_2 = L4_2
    L8_2 = L2_2
    L6_2 = L6_2(L7_2, L8_2)
    L6_2 = L6_2 - 1
    L5_2.maxDrawable = L6_2
    L6_2 = GetPedDrawableVariation
    L7_2 = L4_2
    L8_2 = L2_2
    L6_2 = L6_2(L7_2, L8_2)
    L5_2.currentDrawable = L6_2
    L6_2 = GetPedTextureVariation
    L7_2 = L4_2
    L8_2 = L2_2
    L6_2 = L6_2(L7_2, L8_2)
    L5_2.currentTexture = L6_2
    L6_2 = GetNumberOfPedTextureVariations
    L7_2 = L4_2
    L8_2 = L2_2
    L9_2 = L5_2.currentDrawable
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L6_2 = L6_2 - 1
    L5_2.maxTexture = L6_2
  else
    L6_2 = L2_2 - 100
    L5_2.minDrawable = -1
    L7_2 = GetNumberOfPedPropDrawableVariations
    L8_2 = L4_2
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L7_2 = L7_2 - 1
    L5_2.maxDrawable = L7_2
    L7_2 = GetPedPropIndex
    L8_2 = L4_2
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L5_2.currentDrawable = L7_2
    L7_2 = GetPedPropTextureIndex
    L8_2 = L4_2
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L5_2.currentTexture = L7_2
    L7_2 = GetNumberOfPedPropTextureVariations
    L8_2 = L4_2
    L9_2 = L6_2
    L10_2 = L5_2.currentDrawable
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    L7_2 = L7_2 - 1
    L5_2.maxTexture = L7_2
  end
  L6_2 = math
  L6_2 = L6_2.max
  L7_2 = L5_2.maxTexture
  L8_2 = 0
  L6_2 = L6_2(L7_2, L8_2)
  L5_2.maxTexture = L6_2
  L6_2 = math
  L6_2 = L6_2.max
  L7_2 = L5_2.currentTexture
  L8_2 = 0
  L6_2 = L6_2(L7_2, L8_2)
  L5_2.currentTexture = L6_2
  L6_2 = L2_2 >= 100
  L7_2 = A1_2
  L8_2 = L5_2
  L7_2(L8_2)
  L7_2 = IsModelFreemode
  L8_2 = GetEntityModel
  L9_2 = L4_2
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L8_2(L9_2)
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  if L7_2 and not L6_2 then
    L7_2 = GetUsableClothingHash
    L8_2 = L2_2
    L9_2 = L5_2.currentDrawable
    L10_2 = L5_2.currentTexture
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    L8_2 = TriggerServerEvent
    L9_2 = "rcore_clothing:getSingleItemMetadata"
    L10_2 = L3_2
    L11_2 = L7_2
    L12_2 = HasCurrentShopGotEverythingIdMode
    L12_2 = L12_2()
    L13_2 = HasCurrentShopEverythingFree
    L13_2, L14_2, L15_2, L16_2 = L13_2()
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  else
    L7_2 = Wait
    L8_2 = 100
    L7_2(L8_2)
    if L6_2 then
      L7_2 = "nondlcgta5--"
      L8_2 = L2_2
      L9_2 = "--m1--0"
      L7_2 = L7_2 .. L8_2 .. L9_2
      L8_2 = TriggerEvent
      L9_2 = "rcore_clothing:receiveSingleItemMetadata"
      L10_2 = {}
      L10_2.name_hash = L7_2
      L10_2.component_id = L2_2
      L10_2.drawable_id = -1
      L10_2.texture_id = 0
      L10_2.price = 0
      L11_2 = "~"
      L12_2 = L7_2
      L11_2 = L11_2 .. L12_2
      L10_2.id = L11_2
      L10_2.in_shop = true
      L10_2.isUnset = L6_2
      L8_2(L9_2, L10_2)
    else
      L7_2 = GetUsableHash
      L8_2 = L2_2
      L9_2 = L5_2.currentDrawable
      L10_2 = L5_2.currentTexture
      L7_2 = L7_2(L8_2, L9_2, L10_2)
      if nil == L7_2 then
        L8_2 = TriggerEvent
        L9_2 = "rcore_clothing:receiveSingleItemMetadata"
        L10_2 = {}
        L11_2 = L2_2
        L12_2 = "_"
        L13_2 = L5_2.currentDrawable
        L14_2 = "_"
        L15_2 = L5_2.currentTexture
        L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2
        L10_2.name_hash = L11_2
        L10_2.component_id = L2_2
        L11_2 = L5_2.currentDrawable
        L10_2.drawable_id = L11_2
        L11_2 = L5_2.currentTexture
        L10_2.texture_id = L11_2
        L10_2.price = 0
        L11_2 = "~"
        L12_2 = L2_2
        L13_2 = "_"
        L14_2 = L5_2.currentDrawable
        L15_2 = "_"
        L16_2 = L5_2.currentTexture
        L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2 .. L16_2
        L10_2.id = L11_2
        L10_2.is_blacklisted = 1
        L11_2 = Config
        L11_2 = L11_2.EveryShopHasEverything
        if not L11_2 then
          L11_2 = Config
          L11_2 = L11_2.IdModeHasEverything
        end
        L10_2.in_shop = L11_2
        L8_2(L9_2, L10_2)
      else
        L8_2 = TriggerEvent
        L9_2 = "rcore_clothing:receiveSingleItemMetadata"
        L10_2 = {}
        L10_2.name_hash = L7_2
        L10_2.component_id = L2_2
        L11_2 = L5_2.currentDrawable
        L10_2.drawable_id = L11_2
        L11_2 = L5_2.currentTexture
        L10_2.texture_id = L11_2
        L10_2.price = 0
        L11_2 = "~"
        L12_2 = L7_2
        L11_2 = L11_2 .. L12_2
        L10_2.id = L11_2
        L11_2 = Config
        L11_2 = L11_2.EveryShopHasEverything
        if not L11_2 then
          L11_2 = Config
          L11_2 = L11_2.IdModeHasEverything
        end
        L10_2.in_shop = L11_2
        L8_2(L9_2, L10_2)
      end
    end
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "handleNumbersOnlyChange"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = A0_2.componentId
  L3_2 = A0_2.drawableId
  L4_2 = A0_2.textureId
  L5_2 = A0_2.shopName
  L6_2 = PlayerPedId
  L6_2 = L6_2()
  L7_2 = 0
  if L2_2 < 100 then
    L8_2 = GetNumberOfPedTextureVariations
    L9_2 = L6_2
    L10_2 = L2_2
    L11_2 = L3_2
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L7_2 = L8_2 - 1
  else
    L8_2 = GetNumberOfPedPropTextureVariations
    L9_2 = L6_2
    L10_2 = L2_2 - 100
    L11_2 = L3_2
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L7_2 = L8_2 - 1
  end
  if L4_2 > L7_2 then
    L4_2 = L7_2
  end
  L8_2 = math
  L8_2 = L8_2.max
  L9_2 = L7_2
  L10_2 = 0
  L8_2 = L8_2(L9_2, L10_2)
  L7_2 = L8_2
  L8_2 = math
  L8_2 = L8_2.max
  L9_2 = L4_2
  L10_2 = 0
  L8_2 = L8_2(L9_2, L10_2)
  L4_2 = L8_2
  L8_2 = L2_2 >= 100 and L3_2 < 0
  L9_2 = nil
  if L8_2 then
    L10_2 = ClearPedProp
    L11_2 = L6_2
    L12_2 = L2_2 - 100
    L10_2(L11_2, L12_2)
    L10_2 = "nondlcgta5--"
    L11_2 = L2_2
    L12_2 = "--m1--0"
    L10_2 = L10_2 .. L11_2 .. L12_2
    L9_2 = L10_2
    L10_2 = A1_2
    L11_2 = 0
    L10_2(L11_2)
  else
    L10_2 = GetUsableHash
    L11_2 = L2_2
    L12_2 = L3_2
    L13_2 = L4_2
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L9_2 = L10_2
    L10_2 = ApplyPedClothingItem
    L11_2 = L6_2
    L12_2 = {}
    L12_2.name_hash = L9_2
    L10_2(L11_2, L12_2)
    L10_2 = A1_2
    L11_2 = L7_2
    L10_2(L11_2)
  end
  L10_2 = IsModelFreemode
  L11_2 = GetEntityModel
  L12_2 = L6_2
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L11_2(L12_2)
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  if L10_2 and not L8_2 then
    L10_2 = GetUsableClothingHash
    L11_2 = L2_2
    L12_2 = L3_2
    L13_2 = L4_2
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L11_2 = TriggerServerEvent
    L12_2 = "rcore_clothing:getSingleItemMetadata"
    L13_2 = L5_2
    L14_2 = L10_2
    L15_2 = HasCurrentShopGotEverythingIdMode
    L15_2 = L15_2()
    L16_2 = HasCurrentShopEverythingFree
    L16_2 = L16_2()
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  else
    L10_2 = TriggerEvent
    L11_2 = "rcore_clothing:receiveSingleItemMetadata"
    L12_2 = {}
    L12_2.name_hash = L9_2
    L12_2.component_id = L2_2
    L12_2.drawable_id = L3_2
    L12_2.texture_id = L4_2
    L12_2.price = 0
    L13_2 = "~"
    L14_2 = L9_2
    L13_2 = L13_2 .. L14_2
    L12_2.id = L13_2
    L13_2 = Config
    L13_2 = L13_2.EveryShopHasEverything
    if not L13_2 then
      L13_2 = Config
      L13_2 = L13_2.IdModeHasEverything
      if not L13_2 then
        L13_2 = L8_2
      end
    end
    L12_2.in_shop = L13_2
    L12_2.isUnset = L8_2
    L10_2(L11_2, L12_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "setRecommendedArms"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = A0_2.armsHash
  L3_2 = A0_2.clothingId
  L4_2 = A0_2.groupByDrawable
  L5_2 = L0_1
  L5_2 = L5_2 + 1
  L0_1 = L5_2
  L5_2 = L0_1
  if L4_2 then
    L6_2 = TriggerServerEvent
    L7_2 = "rcore_clothing:setGroupRecommendedArms"
    L8_2 = L5_2
    L9_2 = L3_2
    L10_2 = L2_2
    L6_2(L7_2, L8_2, L9_2, L10_2)
  else
    L6_2 = TriggerServerEvent
    L7_2 = "rcore_clothing:setRecommendedArms"
    L8_2 = L5_2
    L9_2 = L3_2
    L10_2 = L2_2
    L11_2 = L4_2
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  end
  L6_2 = AwaitAsyncResponse
  L7_2 = L5_2
  L6_2(L7_2)
  L6_2 = A1_2
  L7_2 = "ok"
  L6_2(L7_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "setCameraRotation"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = GetEntityHeading
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = A0_2 / 3
  L4_2 = L3_2 + L4_2
  L5_2 = 360
  if L4_2 > L5_2 then
    L4_2 = L4_2 - 360
  elseif L4_2 < 0 then
    L4_2 = L4_2 + 360
  end
  L5_2 = SetEntityHeading
  L6_2 = L2_2
  L7_2 = L4_2
  L5_2(L6_2, L7_2)
  L5_2 = A1_2
  L6_2 = "ok"
  L5_2(L6_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "setCameraVerticalPosition"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2.changeBy
  L3_2 = A0_2.componentId
  if L3_2 then
    L3_2 = A0_2.componentId
    if -1 ~= L3_2 then
      L3_2 = A0_2.componentId
      if L3_2 then
        goto lbl_12
      end
    end
  end
  L3_2 = 11
  ::lbl_12::
  L4_2 = L2_2 / 300
  L4_2 = L4_2 * -1
  L4_2 = L4_2 * -1
  L5_2 = CamSetVerticalScroll
  L6_2 = L3_2
  L7_2 = GetCamVerticalScroll
  L7_2 = L7_2()
  L7_2 = L4_2 + L7_2
  L5_2(L6_2, L7_2)
  L5_2 = A1_2
  L6_2 = "ok"
  L5_2(L6_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "setCameraZoom"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2.componentId
  if L2_2 then
    L2_2 = A0_2.componentId
    if -1 ~= L2_2 then
      L2_2 = A0_2.componentId
      if L2_2 then
        goto lbl_11
      end
    end
  end
  L2_2 = 11
  ::lbl_11::
  L3_2 = A0_2.changeBy
  if L3_2 > 0 then
    L3_2 = CamSetZoom
    L4_2 = L2_2
    L5_2 = CamGetZoom
    L5_2 = L5_2()
    L6_2 = GetZoomStep
    L7_2 = L2_2
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 - L6_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = CamSetZoom
    L4_2 = L2_2
    L5_2 = CamGetZoom
    L5_2 = L5_2()
    L6_2 = GetZoomStep
    L7_2 = L2_2
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 + L6_2
    L3_2(L4_2, L5_2)
  end
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "resetCamera"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = A0_2.componentId
  L3_2 = AnimateEntityRotation
  L4_2 = L2_1
  L3_2(L4_2)
  if L2_2 then
    L3_2 = ClothingCamTransitionToComponent
    L4_2 = PlayerPedId
    L4_2 = L4_2()
    L5_2 = CAM_OFFSETS_CLOTHING_SHOP
    L6_2 = L2_2
    L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "zoomOutCamera"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = ClothingCamTransitionToComponent
  L4_2 = L2_2
  L5_2 = CAM_OFFSETS_CLOTHING_SHOP
  L6_2 = 11
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = A1_2
  L4_2 = "ok"
  L3_2(L4_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "showProcessingCamera"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = A0_2.componentId
  L4_2 = AnimateEntityRotation
  L5_2 = L2_1
  L4_2(L5_2)
  L4_2 = ClothingCamTransitionToComponent
  L5_2 = L2_2
  L6_2 = CAM_OFFSETS_PROCESSING_SHOP
  L7_2 = L3_2 or L7_2
  if not L3_2 then
    L7_2 = 11
  end
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = A1_2
  L5_2 = "ok"
  L4_2(L5_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "pipelineConfirmResult"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = SetNUIFocus
  L3_2 = false
  L2_2(L3_2)
  if A0_2 then
    L2_2 = IsStage4
    L2_2 = L2_2()
    if L2_2 then
      L2_2 = OnPipeline4DialogConfirm
      L2_2()
    else
      L2_2 = OnPipeline2DialogConfirm
      L2_2()
    end
  else
    L2_2 = OnPipeline2DialogCancel
    L2_2()
  end
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "setImageDebugMode"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2
  if A0_2 then
    L2_2 = StartImageDebug
    L2_2()
  else
    L2_2 = StopImageDebug
    L2_2()
  end
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "blacklistCurrent"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = TriggerServerEvent
  L3_2 = "rcore_clothing:blacklistItem"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "resetCurrent"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = TriggerServerEvent
  L3_2 = "rcore_clothing:resetItem"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = SendReactMessage
  L3_2 = "resetClothingItemById"
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNUICallback
L6_1 = "resetCharCreatorStructure"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = A1_2
  L4_2 = GetHeadOptions
  L5_2 = L2_2
  L4_2, L5_2 = L4_2(L5_2)
  L3_2(L4_2, L5_2)
end
L5_1(L6_1, L7_1)
function L5_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2, A9_2, A10_2, A11_2)
  local L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if 3 == A2_2 then
    if A11_2 then
      L12_2 = L1_1
      L13_2 = QueryAvailableArms
      L14_2 = A6_2
      L13_2 = L13_2(L14_2)
      L12_2[A1_2] = L13_2
      return
    else
      A9_2 = true
      A7_2 = true
    end
  end
  if 33 == A2_2 then
    L12_2 = L1_1
    L13_2 = QueryAvailableGloves
    L14_2 = A6_2
    L13_2 = L13_2(L14_2)
    L12_2[A1_2] = L13_2
  else
    L12_2 = GetCurrentShopConfig
    L12_2 = L12_2()
    L13_2 = TriggerServerEvent
    if A7_2 then
      L14_2 = "rcore_clothing:queryShopAll"
      if L14_2 then
        goto lbl_31
      end
    end
    L14_2 = "rcore_clothing:queryShop"
    ::lbl_31::
    L15_2 = A1_2
    L16_2 = A0_2
    L17_2 = GetEntityModel
    L18_2 = PlayerPedId
    L18_2 = L18_2()
    L17_2 = L17_2(L18_2)
    L18_2 = {}
    L18_2.componentId = A2_2
    L18_2.category = A3_2
    L18_2.colors = A4_2
    L18_2.searchQuery = A5_2
    L18_2.lastId = A6_2
    L18_2.groupByDrawable = A8_2
    L18_2.onlyAddons = A9_2
    L18_2.shopConfig = L12_2
    L18_2.notInAnyShop = A10_2
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  end
end
QueryBackend = L5_1
L5_1 = RegisterNetEvent
L6_1 = "rcore_clothing:openClothingShop"
function L7_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L5_2 = PlayerPedId
  L5_2 = L5_2()
  L6_2 = table
  L6_2 = L6_2.insert
  L7_2 = A1_2
  L8_2 = 1
  L9_2 = {}
  L9_2.id = "head"
  L10_2 = _U
  L11_2 = "shop_structure.first_level.character"
  L10_2 = L10_2(L11_2)
  L9_2.label = L10_2
  L9_2.type = "category"
  L9_2.subtype = "head"
  L10_2 = GetHeadOptions
  L11_2 = L5_2
  L10_2 = L10_2(L11_2)
  L9_2.items = L10_2
  L9_2.image = "*img/card_img/pedselect.webp"
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = table
  L6_2 = L6_2.insert
  L7_2 = A1_2
  L8_2 = 1
  L9_2 = {}
  L9_2.id = "outfits"
  L10_2 = _U
  L11_2 = "shop_structure.first_level.outfits"
  L10_2 = L10_2(L11_2)
  L9_2.label = L10_2
  L9_2.type = "category"
  L9_2.subtype = "outfits"
  L10_2 = GetOutfitOptions
  L10_2 = L10_2()
  L9_2.items = L10_2
  L9_2.image = "*img/card_img/my_outfits.webp"
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = GetCurrentShopConfig
  L6_2 = L6_2()
  if L6_2 then
    L7_2 = L6_2.structure
    if L7_2 then
      L7_2 = next
      L8_2 = L6_2.structure
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = FilterShopStructure
        L8_2 = A1_2
        L9_2 = L6_2.structure
        L7_2 = L7_2(L8_2, L9_2)
        A1_2 = L7_2
      end
    end
  end
  L7_2 = SendReactMessage
  L8_2 = "setMenuData"
  L9_2 = A1_2
  L7_2(L8_2, L9_2)
  L7_2 = SendReactMessage
  L8_2 = "setShopData"
  L9_2 = {}
  L9_2.type = A0_2
  L10_2 = Config
  L10_2 = L10_2.ClothingShopLogos
  L10_2 = L10_2[A0_2]
  if not L10_2 then
    L10_2 = Config
    L10_2 = L10_2.ClothingShopLogos
    L10_2 = L10_2.default
  end
  L9_2.logo = L10_2
  if L6_2 then
    L10_2 = L6_2.modifiers
    if L10_2 then
      goto lbl_82
    end
  end
  L10_2 = {}
  ::lbl_82::
  L9_2.modifiers = L10_2
  L9_2.externalServerData = A4_2
  L7_2(L8_2, L9_2)
  L7_2 = SendReactMessage
  L8_2 = "setPermissions"
  L9_2 = A3_2
  L7_2(L8_2, L9_2)
  L7_2 = SendReactMessage
  L8_2 = "setClothingCategories"
  L9_2 = A2_2
  L7_2(L8_2, L9_2)
  L7_2 = GetIsNuiOpen
  L7_2 = L7_2()
  if not L7_2 then
    L7_2 = ShopInit
    L8_2 = L5_2
    L7_2(L8_2)
    L7_2 = OpenNUI
    L7_2()
    L7_2 = StopRenderingMarkers
    L7_2()
    L7_2 = GetEntityHeading
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    L2_1 = L7_2
    L7_2 = Wait
    L8_2 = 1
    L7_2(L8_2)
    currentZoom = 0
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNetEvent
L6_1 = "rcore_clothing:setHairData"
function L7_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SendReactMessage
  L2_2 = "setHairData"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNetEvent
L6_1 = "rcore_clothing:setServerJobs"
function L7_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SendReactMessage
  L2_2 = "setServerJobs"
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNetEvent
L6_1 = "rcore_clothing:receiveSingleItemMetadata"
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  if A0_2 then
    L1_2 = A0_2.component_id
    if L1_2 then
      L1_2 = A0_2.component_id
      if 3 ~= L1_2 then
        L1_2 = A0_2.component_id
        if 10 ~= L1_2 then
          goto lbl_13
        end
      end
      A0_2.in_shop = true
    end
  end
  ::lbl_13::
  L1_2 = A0_2.not_found
  if L1_2 then
    L1_2 = UsableHashOfComponentOrPropToData
    L2_2 = GetShopPed
    L2_2 = L2_2()
    L3_2 = A0_2.not_found
    L4_2 = true
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    L2_2 = {}
    L3_2 = A0_2.not_found
    L2_2.name_hash = L3_2
    L3_2 = L1_2.componentId
    L2_2.component_id = L3_2
    L3_2 = L1_2.drawableId
    L2_2.drawable_id = L3_2
    L3_2 = L1_2.textureId
    L2_2.texture_id = L3_2
    L2_2.price = 0
    L3_2 = "~"
    L4_2 = A0_2.not_found
    L3_2 = L3_2 .. L4_2
    L2_2.id = L3_2
    L3_2 = Config
    L3_2 = L3_2.EveryShopHasEverything
    if not L3_2 then
      L3_2 = Config
      L3_2 = L3_2.IdModeHasEverything
      if not L3_2 then
        L3_2 = L1_2.componentId
        L3_2 = 3 == L3_2
      end
    end
    L2_2.in_shop = L3_2
    L3_2 = SendReactMessage
    L4_2 = "setNumbersOnlyCurrentProduct"
    L5_2 = {}
    L5_2.item = L2_2
    L6_2 = L1_2.componentId
    L5_2.componentId = L6_2
    L6_2 = L1_2.drawableId
    L5_2.drawableId = L6_2
    L6_2 = L1_2.textureId
    L5_2.textureId = L6_2
    L3_2(L4_2, L5_2)
  else
    L1_2 = UsableHashOfComponentOrPropToData
    L2_2 = GetShopPed
    L2_2 = L2_2()
    L3_2 = A0_2.name_hash
    L4_2 = true
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    L2_2 = SendReactMessage
    L3_2 = "setNumbersOnlyCurrentProduct"
    L4_2 = {}
    L4_2.item = A0_2
    L5_2 = L1_2.componentId
    L4_2.componentId = L5_2
    L5_2 = L1_2.drawableId
    L4_2.drawableId = L5_2
    L5_2 = L1_2.textureId
    L4_2.textureId = L5_2
    L2_2(L3_2, L4_2)
  end
end
L5_1(L6_1, L7_1)
L5_1 = RegisterNetEvent
L6_1 = "rcore_clothing:setRecommendedArmsResult"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L1_1
  L3_2 = {}
  L3_2.result = A1_2
  L2_2[A0_2] = L3_2
end
L5_1(L6_1, L7_1)
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = SendReactMessage
  L3_2 = "notify"
  L4_2 = {}
  L4_2.title = A0_2
  L4_2.isError = A1_2
  L2_2(L3_2, L4_2)
end
UINotify = L5_1
L5_1 = RegisterNUICallback
L6_1 = "notify"
function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = NotifyUser
  L3_2 = A0_2.title
  L4_2 = A0_2.isError
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = "ok"
  L2_2(L3_2)
end
L5_1(L6_1, L7_1)
function L5_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L0_1
  L0_2 = L0_2 + 1
  L0_1 = L0_2
  L0_2 = L0_1
  L1_2 = TriggerServerEvent
  L2_2 = "rcore_clothing:getPersonalOutfits"
  L3_2 = L0_2
  L1_2(L2_2, L3_2)
  L1_2 = AwaitAsyncResponse
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.result
  return L2_2
end
GetPersonalOutfits = L5_1
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = L0_1
  L1_2 = L1_2 + 1
  L0_1 = L1_2
  L1_2 = L0_1
  L2_2 = TriggerServerEvent
  L3_2 = "rcore_clothing:getShopOutfits"
  L4_2 = L1_2
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = AwaitAsyncResponse
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.result
  return L3_2
end
GetShopOutfits = L5_1
