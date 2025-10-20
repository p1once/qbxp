local L0_1, L1_1, L2_1, L3_1
L0_1 = {}
function L1_1()
  local L0_2, L1_2
  L0_2 = L0_1
  return L0_2
end
GetAppliedDecals = L1_1
function L1_1(A0_2)
  local L1_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  return L1_2
end
GetAppliedDecalByComponentId = L1_1
function L1_1()
  local L0_2, L1_2
  L0_2 = {}
  L0_1 = L0_2
end
ResetAppliedDecals = L1_1
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = L0_1
  L4_2 = {}
  L5_2 = A1_2
  L6_2 = A2_2
  L7_2 = GetPedDrawableVariation
  L8_2 = PlayerPedId
  L8_2 = L8_2()
  L9_2 = A0_2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = GetPedTextureVariation
  L9_2 = PlayerPedId
  L9_2 = L9_2()
  L10_2 = A0_2
  L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L4_2[3] = L7_2
  L4_2[4] = L8_2
  L4_2[5] = L9_2
  L4_2[6] = L10_2
  L3_2[A0_2] = L4_2
end
SetAppliedDecal = L1_1
L1_1 = Citizen
L1_1 = L1_1.CreateThread
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = {}
  L1_2 = 8
  L2_2 = 11
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  while true do
    L1_2 = PlayerPedId
    L1_2 = L1_2()
    L2_2 = pairs
    L3_2 = L0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = GetPedDrawableVariation
      L9_2 = PlayerPedId
      L9_2 = L9_2()
      L10_2 = L7_2
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = GetPedTextureVariation
      L10_2 = PlayerPedId
      L10_2 = L10_2()
      L11_2 = L7_2
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = L0_1
      L10_2 = L10_2[L7_2]
      if L10_2 then
        L11_2 = L10_2[3]
        if L11_2 == L8_2 then
          L11_2 = L10_2[4]
          if L11_2 == L9_2 then
            goto lbl_35
          end
        end
        L11_2 = UnsetPedDecorationByComponentId
        L12_2 = L7_2
        L11_2(L12_2)
      end
      ::lbl_35::
    end
    L2_2 = Wait
    L3_2 = 1000
    L2_2(L3_2)
  end
end
L1_1(L2_1)
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L1_2 = PlayerPedId
    L1_2 = L1_2()
    L2_2 = GetPedDecorations
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = ClearPedDecorations
    L4_2 = L1_2
    L3_2(L4_2)
    L3_2 = {}
    L4_2 = pairs
    L5_2 = L0_1
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = L9_2[1]
      L11_2 = "_"
      L12_2 = L9_2[2]
      L10_2 = L10_2 .. L11_2 .. L12_2
      L11_2 = L3_2[L10_2]
      if not L11_2 then
        L3_2[L10_2] = 0
      end
      L11_2 = L3_2[L10_2]
      L11_2 = L11_2 + 1
      L3_2[L10_2] = L11_2
    end
    L4_2 = pairs
    L5_2 = L2_2
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = L0_1
      L10_2 = L10_2[A0_2]
      L10_2 = L10_2[1]
      L11_2 = "_"
      L12_2 = L0_1
      L12_2 = L12_2[A0_2]
      L12_2 = L12_2[2]
      L10_2 = L10_2 .. L11_2 .. L12_2
      L11_2 = L0_1
      L11_2 = L11_2[A0_2]
      L11_2 = L11_2[1]
      curAppl1 = L11_2
      L11_2 = L0_1
      L11_2 = L11_2[A0_2]
      L11_2 = L11_2[2]
      curAppl2 = L11_2
      L11_2 = curAppl1
      if L11_2 < 0 then
        L11_2 = curAppl1
        L11_2 = L11_2 + 4.294967296E9
        curAppl1 = L11_2
      end
      L11_2 = curAppl2
      if L11_2 < 0 then
        L11_2 = curAppl2
        L11_2 = L11_2 + 4.294967296E9
        curAppl2 = L11_2
      end
      L11_2 = L9_2[1]
      L12_2 = curAppl1
      if L11_2 == L12_2 then
        L11_2 = L9_2[2]
        L12_2 = curAppl2
        if L11_2 == L12_2 then
          L11_2 = L3_2[L10_2]
          if not L11_2 then
            goto lbl_94
          end
          L11_2 = L3_2[L10_2]
          if not (L11_2 > 1) then
            goto lbl_94
          end
        end
      end
      L11_2 = L3_2[L10_2]
      if L11_2 then
        L11_2 = L3_2[L10_2]
        L11_2 = L11_2 - 1
        L3_2[L10_2] = L11_2
      end
      L11_2 = SetPedDecoration
      L12_2 = L1_2
      L13_2 = L9_2[1]
      L14_2 = L9_2[2]
      L11_2(L12_2, L13_2, L14_2)
      ::lbl_94::
    end
    L4_2 = L0_1
    L4_2[A0_2] = nil
  end
end
UnsetPedDecorationByComponentId = L1_1
L1_1 = AddEventHandler
L2_1 = "rcore_clothing:reapplyDecorations"
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = pairs
  L1_2 = L0_1
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = SetPedDecoration
    L7_2 = PlayerPedId
    L7_2 = L7_2()
    L8_2 = L5_2[1]
    L9_2 = L5_2[2]
    L6_2(L7_2, L8_2, L9_2)
  end
end
L1_1(L2_1, L3_1)
