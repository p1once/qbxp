local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = 1
L1_1 = {}
L2_1 = {}
function L3_1()
  local L0_2, L1_2
  L0_2 = L0_1
  L0_2 = L0_2 + 1
  L0_1 = L0_2
  L0_2 = "target_"
  L1_2 = L0_1
  L0_2 = L0_2 .. L1_2
  return L0_2
end
L4_1 = {}
L4_1.NO_TARGET = 0
L4_1.Q_TARGET = 1
L4_1.BT_TARGET = 2
L4_1.QB_TARGET = 3
L4_1.OX_TARGET = 4
TargetType = L4_1
L4_1 = {}
L5_1 = TargetType
L5_1 = L5_1.NO_TARGET
L4_1[L5_1] = "none"
L5_1 = TargetType
L5_1 = L5_1.Q_TARGET
L4_1[L5_1] = "qtarget"
L5_1 = TargetType
L5_1 = L5_1.BT_TARGET
L4_1[L5_1] = "bt-target"
L5_1 = TargetType
L5_1 = L5_1.QB_TARGET
L4_1[L5_1] = "qb-target"
L5_1 = TargetType
L5_1 = L5_1.OX_TARGET
L4_1[L5_1] = "ox_target"
TargetTypeResourceName = L4_1
function L4_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L5_2 = TargetTypeResourceName
  L6_2 = Config
  L6_2 = L6_2.TargetScript
  L5_2 = L5_2[L6_2]
  L6_2 = L3_1
  L6_2 = L6_2()
  L7_2 = {}
  L8_2 = TargetType
  L8_2 = L8_2.Q_TARGET
  L7_2[L8_2] = true
  L8_2 = TargetType
  L8_2 = L8_2.BT_TARGET
  L7_2[L8_2] = true
  L8_2 = TargetType
  L8_2 = L8_2.QB_TARGET
  L7_2[L8_2] = true
  L8_2 = Config
  L8_2 = L8_2.TargetScript
  L9_2 = TargetType
  L9_2 = L9_2.OX_TARGET
  if L8_2 == L9_2 then
    L8_2 = vector3
    L9_2 = A0_2.x
    L10_2 = A0_2.y
    L11_2 = A0_2.z
    L11_2 = L11_2 - 0.5
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    A0_2 = L8_2
    L8_2 = exports
    L8_2 = L8_2.ox_target
    L9_2 = L8_2
    L8_2 = L8_2.addBoxZone
    L10_2 = {}
    L10_2.name = L6_2
    L10_2.coords = A0_2
    L11_2 = vector3
    L12_2 = A2_2
    L13_2 = A1_2
    L14_2 = 2.0
    L11_2 = L11_2(L12_2, L13_2, L14_2)
    L10_2.size = L11_2
    L10_2.rotation = A3_2
    L11_2 = A0_2.z
    L11_2 = L11_2 - A1_2
    L10_2.minZ = L11_2
    L11_2 = A0_2.z
    L11_2 = L11_2 + A1_2
    L10_2.maxZ = L11_2
    L10_2.options = A4_2
    L10_2.distance = 5.0
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = L2_1
    L9_2[L8_2] = true
  else
    L8_2 = Config
    L8_2 = L8_2.TargetScript
    L8_2 = L7_2[L8_2]
    if L8_2 then
      L8_2 = {}
      L8_2.options = A4_2
      L9_2 = A4_2.distance
      if not L9_2 then
        L9_2 = 5.0
      end
      L8_2.distance = L9_2
      L8_2.heading = A3_2
      L9_2 = exports
      L9_2 = L9_2[L5_2]
      L10_2 = L9_2
      L9_2 = L9_2.AddBoxZone
      L11_2 = L6_2
      L12_2 = A0_2
      L13_2 = A1_2
      L14_2 = A2_2
      L15_2 = {}
      L15_2.name = L6_2
      L15_2.heading = A3_2
      L16_2 = A0_2.z
      L16_2 = L16_2 - A1_2
      L15_2.minZ = L16_2
      L16_2 = A0_2.z
      L16_2 = L16_2 + A1_2
      L15_2.maxZ = L16_2
      L16_2 = L8_2
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
  end
end
CreateTargetZone = L4_1
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = tonumber
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = GetHashKey
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    A0_2 = L2_2
  end
  L2_2 = L1_1
  L2_2[A0_2] = true
  L2_2 = TargetTypeResourceName
  L3_2 = Config
  L3_2 = L3_2.TargetScript
  L2_2 = L2_2[L3_2]
  L3_2 = L3_1
  L3_2 = L3_2()
  L4_2 = {}
  L5_2 = TargetType
  L5_2 = L5_2.Q_TARGET
  L4_2[L5_2] = true
  L5_2 = TargetType
  L5_2 = L5_2.BT_TARGET
  L4_2[L5_2] = true
  L5_2 = TargetType
  L5_2 = L5_2.QB_TARGET
  L4_2[L5_2] = true
  L5_2 = Config
  L5_2 = L5_2.TargetScript
  L6_2 = TargetType
  L6_2 = L6_2.OX_TARGET
  if L5_2 == L6_2 then
    L5_2 = exports
    L5_2 = L5_2.ox_target
    L6_2 = L5_2
    L5_2 = L5_2.addModel
    L7_2 = A0_2
    L8_2 = A1_2
    L5_2(L6_2, L7_2, L8_2)
  else
    L5_2 = Config
    L5_2 = L5_2.TargetScript
    L5_2 = L4_2[L5_2]
    if L5_2 then
      L5_2 = {}
      L5_2.options = A1_2
      L6_2 = A1_2.distance
      if not L6_2 then
        L6_2 = 5.0
      end
      L5_2.distance = L6_2
      L6_2 = exports
      L6_2 = L6_2[L2_2]
      L7_2 = L6_2
      L6_2 = L6_2.AddTargetModel
      L8_2 = A0_2
      L9_2 = L5_2
      L6_2(L7_2, L8_2, L9_2)
    end
  end
end
CreateTargetModel = L4_1
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = TargetTypeResourceName
  L1_2 = Config
  L1_2 = L1_2.TargetScript
  L0_2 = L0_2[L1_2]
  L1_2 = L3_1
  L1_2 = L1_2()
  L2_2 = {}
  L3_2 = TargetType
  L3_2 = L3_2.Q_TARGET
  L2_2[L3_2] = true
  L3_2 = TargetType
  L3_2 = L3_2.BT_TARGET
  L2_2[L3_2] = true
  L3_2 = TargetType
  L3_2 = L3_2.QB_TARGET
  L2_2[L3_2] = true
  L3_2 = Config
  L3_2 = L3_2.TargetScript
  L4_2 = TargetType
  L4_2 = L4_2.OX_TARGET
  if L3_2 == L4_2 then
    L3_2 = pairs
    L4_2 = L1_1
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = exports
      L9_2 = L9_2.ox_target
      L10_2 = L9_2
      L9_2 = L9_2.removeModel
      L11_2 = L7_2
      L9_2(L10_2, L11_2)
    end
    L3_2 = pairs
    L4_2 = L2_1
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = exports
      L9_2 = L9_2.ox_target
      L10_2 = L9_2
      L9_2 = L9_2.removeZone
      L11_2 = L7_2
      L9_2(L10_2, L11_2)
    end
  else
    L3_2 = Config
    L3_2 = L3_2.TargetScript
    L3_2 = L2_2[L3_2]
    if L3_2 then
      L3_2 = 1
      L4_2 = L0_1
      L5_2 = 1
      for L6_2 = L3_2, L4_2, L5_2 do
        L7_2 = exports
        L7_2 = L7_2[L0_2]
        L8_2 = L7_2
        L7_2 = L7_2.RemoveZone
        L9_2 = "target_"
        L10_2 = L6_2
        L9_2 = L9_2 .. L10_2
        L7_2(L8_2, L9_2)
      end
      L3_2 = Config
      L3_2 = L3_2.TargetScript
      L4_2 = TargetType
      L4_2 = L4_2.BT_TARGET
      if L3_2 ~= L4_2 then
        L3_2 = pairs
        L4_2 = L1_1
        L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
        for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
          L9_2 = exports
          L9_2 = L9_2[L0_2]
          L10_2 = L9_2
          L9_2 = L9_2.RemoveTargetModel
          L11_2 = L7_2
          L9_2(L10_2, L11_2)
        end
      end
    end
  end
  L3_2 = {}
  L1_1 = L3_2
  L3_2 = {}
  L2_1 = L3_2
end
RemoveAllTargetZones = L4_1
