local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = IsEntityAPed
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = A1_2.skin
    if L3_2 then
      L3_2 = type
      L4_2 = A1_2.skin
      L3_2 = L3_2(L4_2)
      if "table" == L3_2 then
        A1_2 = A1_2.skin
      end
    end
    L3_2 = ApplyPedClothing
    L4_2 = A0_2
    L5_2 = A1_2
    L6_2 = A2_2
    L3_2(L4_2, L5_2, L6_2)
  else
    L3_2 = print
    L4_2 = "ERROR: Entity is not a ped"
    L3_2(L4_2)
  end
end
function L1_1()
  local L0_2, L1_2
  L0_2 = GetCurrentOutfit
  return L0_2()
end
function L2_1()
  local L0_2, L1_2, L2_2
  L0_2 = L1_1
  L0_2 = L0_2()
  if L0_2 then
    L1_2 = L0_2.skin
    if L1_2 then
      L1_2 = {}
      L2_2 = L0_2.skin
      L2_2 = L2_2.components
      L1_2.components = L2_2
      L2_2 = L0_2.skin
      L2_2 = L2_2.props
      L1_2.props = L2_2
      if L1_2 then
        goto lbl_20
      end
    end
  end
  L1_2 = {}
  ::lbl_20::
  L2_2 = L1_2.components
  if L2_2 then
    L2_2 = L1_2.components
    L2_2["0"] = nil
    L2_2 = L1_2.components
    L2_2["2"] = nil
  end
  return L1_2
end
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = ApplyPlayerClothingOnSpawn
  L3_2 = A0_2.ped_model
  L4_2 = A0_2.skin
  L5_2 = A1_2
  L2_2(L3_2, L4_2, L5_2)
end
L4_1 = exports
L5_1 = "getSkinByIdentifier"
function L6_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetSkinByIdentifier
  L2_2 = A0_2
  return L1_2(L2_2)
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "getPlayerSkin"
L6_1 = L1_1
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "setPedSkin"
L6_1 = L0_1
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "setPlayerSkin"
L6_1 = L3_1
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "getSkinchangerSkin"
function L6_1()
  local L0_2, L1_2
  L0_2 = PedToSkinchanger
  return L0_2()
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "getPlayerClothing"
L6_1 = L2_1
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "GetPedList"
function L6_1()
  local L0_2, L1_2, L2_2
  L0_2 = {}
  L1_2 = "mp_m_freemode_01"
  L2_2 = "mp_f_freemode_01"
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  return L0_2
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "setPedComponent"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if A1_2 then
    L2_2 = IsPedFreemode
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = A1_2.component_id
      if 0 ~= L2_2 then
        L2_2 = A1_2.component_id
        if 2 ~= L2_2 then
          goto lbl_15
        end
      end
      return
    end
    ::lbl_15::
    L2_2 = SetPedComponentVariation
    L3_2 = A0_2
    L4_2 = A1_2.component_id
    L5_2 = A1_2.drawable
    L6_2 = A1_2.texture
    L7_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  end
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "setPedProp"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = prop
  if L2_2 then
    L2_2 = prop
    L2_2 = L2_2.drawable
    if -1 == L2_2 then
      L2_2 = ClearPedProp
      L3_2 = A0_2
      L4_2 = prop
      L4_2 = L4_2.prop_id
      L2_2(L3_2, L4_2)
    else
      L2_2 = SetPedPropIndex
      L3_2 = A0_2
      L4_2 = prop
      L4_2 = L4_2.prop_id
      L5_2 = prop
      L5_2 = L5_2.drawable
      L6_2 = prop
      L6_2 = L6_2.texture
      L7_2 = false
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    end
  end
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "setClothingByHash"
function L6_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = ApplyPedClothingItem
  L3_2 = A0_2
  L4_2 = {}
  L4_2.name_hash = A1_2
  L2_2(L3_2, L4_2)
end
L4_1(L5_1, L6_1)
L4_1 = exports
L5_1 = "fixArms"
L6_1 = FixArmsForCurrentTop
L4_1(L5_1, L6_1)
