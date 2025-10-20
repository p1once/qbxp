local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = {}
L0_1[0] = 45
L1_1 = {}
L1_1.hash = 166057222
L1_1.drawable = 0
L0_1[1] = L1_1
L1_1 = {}
L1_1.hash = 137479525
L1_1.drawable = 0
L0_1[2] = L1_1
L1_1 = {}
L1_1.hash = -816754991
L1_1.drawable = 13
L0_1[3] = L1_1
L1_1 = {}
L1_1.hash = 308310148
L1_1.drawable = 11
L0_1[4] = L1_1
L1_1 = {}
L1_1.hash = 1925574525
L1_1.drawable = 0
L0_1[5] = L1_1
L1_1 = {}
L1_1.hash = 1572157304
L1_1.drawable = 13
L0_1[6] = L1_1
L1_1 = {}
L1_1.hash = -1099335869
L1_1.drawable = 0
L0_1[7] = L1_1
L1_1 = {}
L1_1.hash = -84053433
L1_1.drawable = 15
L0_1[8] = L1_1
L1_1 = {}
L1_1.hash = -1813973659
L1_1.drawable = 0
L0_1[9] = L1_1
L1_1 = {}
L1_1.hash = -1409690663
L1_1.drawable = 0
L0_1[10] = L1_1
L1_1 = {}
L1_1.hash = -1845631030
L1_1.drawable = 15
L0_1[11] = L1_1
L1_1 = {}
L1_1[0] = 45
L2_1 = {}
L2_1.hash = -1890584569
L2_1.drawable = 0
L1_1[1] = L2_1
L2_1 = {}
L2_1.hash = -2079230364
L2_1.drawable = 0
L1_1[2] = L2_1
L2_1 = {}
L2_1.hash = 551818905
L2_1.drawable = 8
L1_1[3] = L2_1
L2_1 = {}
L2_1.hash = 1165574076
L2_1.drawable = 13
L1_1[4] = L2_1
L2_1 = {}
L2_1.hash = 1333836801
L2_1.drawable = 0
L1_1[5] = L2_1
L2_1 = {}
L2_1.hash = -529650958
L2_1.drawable = 12
L1_1[6] = L2_1
L2_1 = {}
L2_1.hash = -151102289
L2_1.drawable = 0
L1_1[7] = L2_1
L2_1 = {}
L2_1.hash = 1786656489
L2_1.drawable = 2
L1_1[8] = L2_1
L2_1 = {}
L2_1.hash = -1184316816
L2_1.drawable = 0
L1_1[9] = L2_1
L2_1 = {}
L2_1.hash = 1321565075
L2_1.drawable = 0
L1_1[10] = L2_1
L2_1 = {}
L2_1.hash = 779029149
L2_1.drawable = 440
L1_1[11] = L2_1
L2_1 = {}
L3_1 = 0
L4_1 = 1
L5_1 = 2
L6_1 = 6
L7_1 = 7
L2_1[1] = L3_1
L2_1[2] = L4_1
L2_1[3] = L5_1
L2_1[4] = L6_1
L2_1[5] = L7_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L2_2 = ClearPedDecorations
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = L0_1
  if -1667301416 == A0_2 then
    L2_2 = L1_1
  end
  L3_2 = 0
  L4_2 = 11
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = type
    L8_2 = L2_2[L6_2]
    L7_2 = L7_2(L8_2)
    if "table" == L7_2 then
      L7_2 = UsableHashToData
      L8_2 = L1_2
      L9_2 = L2_2[L6_2]
      L9_2 = L9_2.hash
      L7_2 = L7_2(L8_2, L9_2)
      L8_2 = SetPedComponentVariation
      L9_2 = L1_2
      L10_2 = L7_2.componentId
      L11_2 = L7_2.drawableId
      L12_2 = L7_2.textureId
      L13_2 = 0
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    else
      L7_2 = SetPedComponentVariation
      L8_2 = L1_2
      L9_2 = L6_2
      L10_2 = L2_2[L6_2]
      L11_2 = 0
      L12_2 = 0
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    end
  end
  L3_2 = pairs
  L4_2 = L2_1
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = ClearPedProp
    L10_2 = L1_2
    L11_2 = L8_2
    L9_2(L10_2, L11_2)
  end
  L3_2 = SetPedHeadBlendData
  L4_2 = L1_2
  L5_2 = 45
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
InvisibilityMakeInvisible = L3_1
