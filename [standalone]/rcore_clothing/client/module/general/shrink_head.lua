local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = {}
L1_1 = {}
L2_1 = false
function L3_1()
  local L0_2, L1_2
  L0_2 = L2_1
  return L0_2
end
IsHeadShrinked = L3_1
function L3_1()
  local L0_2, L1_2
  L0_2 = L0_1
  return L0_2
end
GetPreShrink = L3_1
function L3_1()
  local L0_2, L1_2
  L0_2 = L1_1
  return L0_2
end
GetPreShrinkHeadblend = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = IsHeadShrinked
  L1_2 = L1_2()
  if L1_2 then
    return
  end
  L1_2 = GetFormattedPedHeadblendData
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L1_1 = L1_2
  L1_2 = 0
  L2_2 = 19
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = L0_1
    L6_2 = GetPedFaceFeature
    L7_2 = A0_2
    L8_2 = L4_2
    L6_2 = L6_2(L7_2, L8_2)
    L5_2[L4_2] = L6_2
  end
  L1_2 = IsPedFreemode
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = SetPedHeadBlendData
    L2_2 = A0_2
    L3_2 = GetEntityModel
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if 1885233650 == L3_2 then
      L3_2 = 0
      if L3_2 then
        goto lbl_37
      end
    end
    L3_2 = 21
    ::lbl_37::
    L4_2 = 0
    L5_2 = 0
    L6_2 = L1_1
    L6_2 = L6_2[4]
    L7_2 = L1_1
    L7_2 = L7_2[5]
    L8_2 = L1_1
    L8_2 = L8_2[6]
    L9_2 = 0.0
    L10_2 = L1_1
    L10_2 = L10_2[8]
    L11_2 = 0.0
    L12_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
  L1_2 = 0
  L2_2 = 19
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = SetPedFaceFeature
    L6_2 = A0_2
    L7_2 = L4_2
    L8_2 = 0.0
    L5_2(L6_2, L7_2, L8_2)
  end
  L1_2 = true
  L2_1 = L1_2
end
ShrinkHead = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = IsHeadShrinked
  L1_2 = L1_2()
  if not L1_2 then
    return
  end
  L1_2 = IsPedFreemode
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = SetPedHeadBlendData
    L2_2 = A0_2
    L3_2 = L1_1
    L3_2 = L3_2[1]
    L4_2 = L1_1
    L4_2 = L4_2[2]
    L5_2 = L1_1
    L5_2 = L5_2[3]
    L6_2 = L1_1
    L6_2 = L6_2[4]
    L7_2 = L1_1
    L7_2 = L7_2[5]
    L8_2 = L1_1
    L8_2 = L8_2[6]
    L9_2 = L1_1
    L9_2 = L9_2[7]
    L10_2 = L1_1
    L10_2 = L10_2[8]
    L11_2 = L1_1
    L11_2 = L11_2[9]
    L12_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
  L1_2 = 0
  L2_2 = 19
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = SetPedFaceFeature
    L6_2 = A0_2
    L7_2 = L4_2
    L8_2 = L0_1
    L8_2 = L8_2[L4_2]
    L5_2(L6_2, L7_2, L8_2)
  end
  L1_2 = {}
  L0_1 = L1_2
  L1_2 = false
  L2_1 = L1_2
end
UnshrinkHead = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = 1
  L2_2 = GetPedDrawableVariation
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = GetPedTextureVariation
  L4_2 = A0_2
  L5_2 = L1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = GetHashNameForComponent
  L5_2 = A0_2
  L6_2 = L1_2
  L7_2 = L2_2
  L8_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = DoesShopPedApparelHaveRestrictionTag
  L6_2 = L4_2
  L7_2 = -921710083
  L8_2 = L1_2
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L5_2 = not L5_2
  L5_2 = not L5_2
  return L5_2
end
ShouldHeadShrink = L3_1
L3_1 = Citizen
L3_1 = L3_1.CreateThread
function L4_1()
  local L0_2, L1_2, L2_2
  while true do
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = EnsureHeadShrink
    L1_2()
    L1_2 = Wait
    L2_2 = 500
    L1_2(L2_2)
  end
end
L3_1(L4_1)
function L3_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = ShouldHeadShrink
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L2_2 = IsHeadShrinked
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = ShrinkHead
      L3_2 = L0_2
      L2_2(L3_2)
  end
  elseif not L1_2 then
    L2_2 = IsHeadShrinked
    L2_2 = L2_2()
    if L2_2 then
      L2_2 = UnshrinkHead
      L3_2 = L0_2
      L2_2(L3_2)
    end
  end
end
EnsureHeadShrink = L3_1
L3_1 = AddEventHandler
L4_1 = "onResourceStop"
function L5_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 == L1_2 then
    L1_2 = PlayerPedId
    L1_2 = L1_2()
    L2_2 = UnshrinkHead
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L3_1(L4_1, L5_1)
