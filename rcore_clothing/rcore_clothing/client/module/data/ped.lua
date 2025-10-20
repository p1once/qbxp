local L0_1, L1_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = DataView
  L1_2 = L1_2.ArrayBuffer
  L2_2 = 128
  L1_2 = L1_2(L2_2)
  L2_2 = Citizen
  L2_2 = L2_2.InvokeNative
  L3_2 = 2830157900151113168
  L4_2 = A0_2
  L6_2 = L1_2
  L5_2 = L1_2.Buffer
  L5_2 = L5_2(L6_2)
  L6_2 = Citizen
  L6_2 = L6_2.ReturnResultAnyway
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  if L2_2 then
    L2_2 = {}
    L4_2 = L1_2
    L3_2 = L1_2.GetInt32
    L5_2 = 0
    L3_2 = L3_2(L4_2, L5_2)
    L5_2 = L1_2
    L4_2 = L1_2.GetInt32
    L6_2 = 8
    L4_2 = L4_2(L5_2, L6_2)
    L6_2 = L1_2
    L5_2 = L1_2.GetInt32
    L7_2 = 16
    L5_2 = L5_2(L6_2, L7_2)
    L7_2 = L1_2
    L6_2 = L1_2.GetInt32
    L8_2 = 24
    L6_2 = L6_2(L7_2, L8_2)
    L8_2 = L1_2
    L7_2 = L1_2.GetInt32
    L9_2 = 32
    L7_2 = L7_2(L8_2, L9_2)
    L9_2 = L1_2
    L8_2 = L1_2.GetInt32
    L10_2 = 40
    L8_2 = L8_2(L9_2, L10_2)
    L10_2 = L1_2
    L9_2 = L1_2.GetFloat32
    L11_2 = 48
    L9_2 = L9_2(L10_2, L11_2)
    L11_2 = L1_2
    L10_2 = L1_2.GetFloat32
    L12_2 = 56
    L10_2 = L10_2(L11_2, L12_2)
    L12_2 = L1_2
    L11_2 = L1_2.GetFloat32
    L13_2 = 64
    L11_2, L12_2, L13_2 = L11_2(L12_2, L13_2)
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
    return L2_2
  end
  L2_2 = {}
  L3_2 = 1
  L4_2 = 1
  L5_2 = 1
  L6_2 = 1
  L7_2 = 1
  L8_2 = 1
  L9_2 = 0.0
  L10_2 = 0.0
  L11_2 = 0.0
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L2_2[8] = L10_2
  L2_2[9] = L11_2
  return L2_2
end
GetFormattedPedHeadblendData = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = GetPedDrawableVariation
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = GetPedTextureVariation
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = GetHashNameForComponent
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = L2_2
  L8_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = GetUsableHash
  L6_2 = A1_2
  L7_2 = L2_2
  L8_2 = L3_2
  L9_2 = L4_2
  return L5_2(L6_2, L7_2, L8_2, L9_2)
end
GetComponentUsableHash = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = {}
  L2_2 = 0
  L3_2 = 7
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = GetPedSinglePropData
    L7_2 = A0_2
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L1_2[L5_2] = L6_2
  end
  return L1_2
end
GetPedPropData = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = GetPedPropIndex
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = GetPedPropTextureIndex
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = {}
  L5_2 = L2_2
  L6_2 = L3_2
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  return L4_2
end
GetPedSinglePropData = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = {}
  L2_2 = 0
  L3_2 = 11
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = GetPedSingleComponentData
    L7_2 = A0_2
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L1_2[L5_2] = L6_2
  end
  return L1_2
end
GetPedComponentData = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = GetPedDrawableVariation
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = GetPedTextureVariation
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = GetPedPaletteVariation
  L5_2 = A0_2
  L6_2 = A1_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = {}
  L6_2 = L2_2
  L7_2 = L3_2
  L8_2 = L4_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  return L5_2
end
GetPedSingleComponentData = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = GetPedHairColor
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = GetPedHairHighlightColor
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = L1_2
  L5_2 = L2_2
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  return L3_2
end
GetHairColorData = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = IsHeadShrinked
  L1_2 = L1_2()
  if L1_2 then
    L1_2 = GetPreShrink
    return L1_2()
  end
  L1_2 = {}
  L2_2 = 0
  L3_2 = 19
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = GetPedFaceFeature
    L7_2 = A0_2
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L1_2[L5_2] = L6_2
  end
  return L1_2
end
GetPedFaceFeatures = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = {}
  L2_2 = 0
  L3_2 = 12
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = GetPedHeadOverlayData
    L7_2 = A0_2
    L8_2 = L5_2
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2, L8_2)
    L12_2 = {}
    L13_2 = L7_2
    L14_2 = L8_2
    L15_2 = L9_2
    L16_2 = L10_2
    L17_2 = L11_2
    L12_2[1] = L13_2
    L12_2[2] = L14_2
    L12_2[3] = L15_2
    L12_2[4] = L16_2
    L12_2[5] = L17_2
    L1_2[L5_2] = L12_2
  end
  return L1_2
end
GetPedHeadOverlays = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = GetCurrentShopConfig
  L0_2 = L0_2()
  L1_2 = L0_2 or L1_2
  if L0_2 then
    L1_2 = L0_2.modifiers
    if L1_2 then
      L1_2 = L0_2.modifiers
      L2_2 = SHOP_MODIFIERS
      L2_2 = L2_2.JOB_CHANGING_ROOM
      L1_2 = L1_2[L2_2]
    end
  end
  L2_2 = {}
  L3_2 = {}
  L3_2.subtype = "my_outfits"
  L3_2.id = "my_outfits"
  L3_2.type = "category"
  L4_2 = _U
  L5_2 = "outfits.my_outfits"
  L4_2 = L4_2(L5_2)
  L3_2.label = L4_2
  L3_2.image = "*img/card_img/my_outfits.webp"
  L4_2 = {}
  L4_2.subtype = "global_outfits"
  L4_2.id = "global_outfits"
  L4_2.type = "category"
  if L1_2 then
    L5_2 = _U
    L6_2 = "outfits.job_outfits"
    L5_2 = L5_2(L6_2)
    if L5_2 then
      goto lbl_39
    end
  end
  L5_2 = _U
  L6_2 = "outfits.shop_outfits"
  L5_2 = L5_2(L6_2)
  ::lbl_39::
  L4_2.label = L5_2
  if L1_2 then
    L5_2 = "*img/card_img/job_outfits.webp"
    if L5_2 then
      goto lbl_46
    end
  end
  L5_2 = "*img/card_img/shop_outfits.webp"
  ::lbl_46::
  L4_2.image = L5_2
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  return L2_2
end
GetOutfitOptions = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = RequestModel
  L2_2 = A0_2
  L1_2(L2_2)
  while true do
    L1_2 = HasModelLoaded
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      break
    end
    L1_2 = Wait
    L2_2 = 0
    L1_2(L2_2)
  end
  L1_2 = SetPlayerModel
  L2_2 = PlayerId
  L2_2 = L2_2()
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SetModelAsNoLongerNeeded
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = IsModelFreemode
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = SetPedHeadBlendData
    L2_2 = PlayerPedId
    L2_2 = L2_2()
    L3_2 = 0
    L4_2 = 0
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
end
LoadAndSetModel = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L5_2 = GetEntityModel
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  if 8 == A1_2 then
    L6_2 = GetPedCollectionNameFromDrawable
    L7_2 = A0_2
    L8_2 = A1_2
    L9_2 = A2_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L7_2 = GetPedCollectionLocalIndexFromDrawable
    L8_2 = A0_2
    L9_2 = A1_2
    L10_2 = A2_2
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    if 1885233650 == L5_2 then
      if 123 == A2_2 or "mp_m_christmas2017" == L6_2 and 1 == L7_2 then
        L8_2 = SetPedConfigFlag
        L9_2 = A0_2
        L10_2 = 409
        L11_2 = true
        L8_2(L9_2, L10_2, L11_2)
      end
    elseif -1667301416 == L5_2 and (153 == A2_2 or "mp_f_christmas2017" == L6_2 and 1 == L7_2) then
      L8_2 = SetPedConfigFlag
      L9_2 = A0_2
      L10_2 = 409
      L11_2 = true
      L8_2(L9_2, L10_2, L11_2)
    end
  end
  L6_2 = SetPedComponentVariation
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = A3_2
  L11_2 = A4_2
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  if 1 == A1_2 then
    L6_2 = UnshrinkHead
    L7_2 = A0_2
    L6_2(L7_2)
    L6_2 = EnsureHeadShrink
    L6_2()
  end
end
RcoreSetPedComponentVariation = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = Config
  L1_2 = L1_2.PedDefaults
  if not L1_2 then
    return
  end
  L1_2 = GetEntityModel
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = Config
  L2_2 = L2_2.PedDefaults
  L2_2 = L2_2[L1_2]
  if L2_2 then
    L2_2 = pairs
    L3_2 = Config
    L3_2 = L3_2.PedDefaults
    L3_2 = L3_2[L1_2]
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = type
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if "table" == L8_2 then
        L8_2 = RcoreSetPedComponentVariation
        L9_2 = A0_2
        L10_2 = L6_2
        L11_2 = L7_2[1]
        L12_2 = L7_2[2]
        L13_2 = 2
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      else
        L8_2 = RcoreSetPedComponentVariation
        L9_2 = A0_2
        L10_2 = L6_2
        L11_2 = L7_2
        L12_2 = 0
        L13_2 = 2
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      end
    end
  end
end
CustomSetDefaultVariations = L0_1
