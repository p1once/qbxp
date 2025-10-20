local L0_1, L1_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = string
  L1_2 = L1_2.find
  L2_2 = A0_2
  L3_2 = "_"
  L1_2 = L1_2(L2_2, L3_2)
  L1_2 = nil ~= L1_2
  return L1_2
end
containsUnderscore = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = string
  L1_2 = L1_2.find
  L2_2 = A0_2
  L3_2 = "%-%-"
  L1_2 = L1_2(L2_2, L3_2)
  L1_2 = nil ~= L1_2
  return L1_2
end
containsDoubleDash = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if nil == A1_2 then
    A1_2 = "%s"
  end
  L2_2 = {}
  L3_2 = string
  L3_2 = L3_2.gmatch
  L4_2 = A0_2
  L5_2 = "([^"
  L6_2 = A1_2
  L7_2 = "]+)"
  L5_2 = L5_2 .. L6_2 .. L7_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
  for L7_2 in L3_2, L4_2, L5_2, L6_2 do
    L8_2 = table
    L8_2 = L8_2.insert
    L9_2 = L2_2
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
  end
  return L2_2
end
mysplit = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = string
  L1_2 = L1_2.sub
  L2_2 = A0_2
  L3_2 = 1
  L4_2 = 1
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "m" == L1_2 then
    L2_2 = tostring
    L3_2 = tonumber
    L4_2 = string
    L4_2 = L4_2.sub
    L5_2 = A0_2
    L6_2 = 2
    L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L3_2 = -L3_2
    return L2_2(L3_2)
  end
  return A0_2
end
handleSmartMinus = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if nil == A1_2 then
    A1_2 = "%s"
  end
  L2_2 = {}
  L3_2 = string
  L3_2 = L3_2.gmatch
  L4_2 = A0_2
  L5_2 = "([^"
  L6_2 = A1_2
  L7_2 = "]+)"
  L5_2 = L5_2 .. L6_2 .. L7_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
  for L7_2 in L3_2, L4_2, L5_2, L6_2 do
    L8_2 = table
    L8_2 = L8_2.insert
    L9_2 = L2_2
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
  end
  L3_2 = {}
  L4_2 = #L2_2
  L4_2 = L4_2 - 3
  L4_2 = L2_2[L4_2]
  L5_2 = #L2_2
  L5_2 = L5_2 - 2
  L5_2 = L2_2[L5_2]
  L6_2 = handleSmartMinus
  L7_2 = #L2_2
  L7_2 = L7_2 - 1
  L7_2 = L2_2[L7_2]
  L6_2 = L6_2(L7_2)
  L7_2 = #L2_2
  L7_2 = L2_2[L7_2]
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  return L3_2
end
clothingSplit = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = nil
  L5_2 = nil
  if A0_2 >= 100 then
    L6_2 = GetPedCollectionNameFromProp
    L7_2 = L3_2
    L8_2 = A0_2 - 100
    L9_2 = A1_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L4_2 = L6_2
    L6_2 = GetPedCollectionLocalIndexFromProp
    L7_2 = L3_2
    L8_2 = A0_2 - 100
    L9_2 = A1_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L5_2 = L6_2
  else
    L6_2 = GetPedCollectionNameFromDrawable
    L7_2 = L3_2
    L8_2 = A0_2
    L9_2 = A1_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L4_2 = L6_2
    L6_2 = GetPedCollectionLocalIndexFromDrawable
    L7_2 = L3_2
    L8_2 = A0_2
    L9_2 = A1_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L5_2 = L6_2
  end
  if "" == L4_2 then
    L4_2 = "nondlcgta5"
  end
  if nil == L4_2 then
    return
  end
  L6_2 = L4_2
  L7_2 = "--"
  L8_2 = A0_2
  L9_2 = "--"
  L10_2 = L5_2
  L11_2 = "--"
  L12_2 = A2_2
  L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2
  return L6_2
end
GetUsableHash = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = ResolveClothingItemToData
  L3_2 = A0_2
  L4_2 = {}
  L4_2.name_hash = A1_2
  return L2_2(L3_2, L4_2)
end
UsableHashToData = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = ResolveClothingItemToData
  L4_2 = A0_2
  L5_2 = {}
  L5_2.name_hash = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = L3_2.componentId
    if L4_2 then
      L4_2 = L3_2.componentId
      if not (L4_2 >= 100) then
        goto lbl_23
      end
    end
  end
  L4_2 = ResolvePropItemToData
  L5_2 = A0_2
  L6_2 = {}
  L6_2.name_hash = A1_2
  L7_2 = A2_2
  do return L4_2(L5_2, L6_2, L7_2) end
  ::lbl_23::
  return L3_2
end
UsableHashOfComponentOrPropToData = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = PlayerPedId
  L3_2 = L3_2()
  L4_2 = nil
  if A0_2 < 100 then
    L5_2 = GetHashNameForComponent
    L6_2 = L3_2
    L7_2 = A0_2
    L8_2 = A1_2
    L9_2 = A2_2
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
    L4_2 = L5_2
  else
    L5_2 = GetHashNameForProp
    L6_2 = L3_2
    L7_2 = A0_2
    L8_2 = A1_2
    L9_2 = A2_2
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
    L4_2 = L5_2
  end
  L5_2 = GetUsableHash
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = L4_2
  return L5_2(L6_2, L7_2, L8_2, L9_2)
end
GetUsableClothingHash = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = {}
  L3_2 = containsDoubleDash
  L4_2 = A1_2.name_hash
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = clothingSplit
    L4_2 = A1_2.name_hash
    L5_2 = "--"
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = L3_2[1]
    L5_2 = tonumber
    L6_2 = L3_2[2]
    L5_2 = L5_2(L6_2)
    L6_2 = tonumber
    L7_2 = L3_2[3]
    L6_2 = L6_2(L7_2)
    L7_2 = tonumber
    L8_2 = L3_2[4]
    L7_2 = L7_2(L8_2)
    if L5_2 >= 100 then
      L8_2 = {}
      return L8_2
    end
    L8_2 = 0
    if L5_2 <= 11 then
      L9_2 = GetPedPaletteVariation
      L10_2 = A0_2
      L11_2 = L5_2
      L9_2 = L9_2(L10_2, L11_2)
      L8_2 = L9_2
    end
    L9_2 = L6_2
    if "nondlcgta5" ~= L4_2 then
      L10_2 = GetPedDrawableGlobalIndexFromCollection
      L11_2 = A0_2
      L12_2 = L5_2
      L13_2 = L4_2
      L14_2 = L6_2
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
      L9_2 = L10_2
    end
    L2_2.componentId = L5_2
    L2_2.drawableId = L9_2
    L2_2.textureId = L7_2
    L2_2.palette = L8_2
  else
    L3_2 = containsUnderscore
    L4_2 = A1_2.name_hash
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = A1_2.name_hash
      L4_2 = L3_2
      L3_2 = L3_2.gsub
      L5_2 = "\""
      L6_2 = ""
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      A1_2.name_hash = L3_2
      L3_2 = mysplit
      L4_2 = A1_2.name_hash
      L5_2 = "_"
      L3_2 = L3_2(L4_2, L5_2)
      L4_2 = 0
      L5_2 = tonumber
      L6_2 = L3_2[1]
      L5_2 = L5_2(L6_2)
      if L5_2 <= 11 then
        L5_2 = GetPedPaletteVariation
        L6_2 = A0_2
        L7_2 = tonumber
        L8_2 = L3_2[1]
        L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L7_2(L8_2)
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
        L4_2 = L5_2
      end
      L5_2 = tonumber
      L6_2 = L3_2[1]
      L5_2 = L5_2(L6_2)
      L2_2.componentId = L5_2
      L5_2 = tonumber
      L6_2 = L3_2[2]
      L5_2 = L5_2(L6_2)
      L2_2.drawableId = L5_2
      L5_2 = tonumber
      L6_2 = L3_2[3]
      L5_2 = L5_2(L6_2)
      L2_2.textureId = L5_2
      L2_2.palette = L4_2
    else
      L3_2 = tonumber
      L4_2 = A1_2.name_hash
      L3_2 = L3_2(L4_2)
      L4_2 = GetShopPedComponent
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      L5_2 = L4_2.ComponentType
      if L5_2 then
        L5_2 = L4_2.ComponentType
        if L5_2 > 0 then
          L5_2 = 0
          L6_2 = L4_2.ComponentType
          if L6_2 <= 11 then
            L6_2 = GetPedPaletteVariation
            L7_2 = A0_2
            L8_2 = L4_2.ComponentType
            L6_2 = L6_2(L7_2, L8_2)
            L5_2 = L6_2
          end
          L6_2 = L4_2.ComponentType
          L2_2.componentId = L6_2
          L6_2 = L4_2.Drawable
          L2_2.drawableId = L6_2
          L6_2 = L4_2.Texture
          L2_2.textureId = L6_2
          L2_2.palette = L5_2
        end
      end
    end
  end
  L3_2 = A1_2.decal_collection_hash
  if L3_2 then
    L3_2 = A1_2.decal_collection_hash
    if 0 ~= L3_2 then
      L3_2 = A1_2.decal_name_hash
      if L3_2 then
        L3_2 = A1_2.decal_name_hash
        if 0 ~= L3_2 then
          L3_2 = A1_2.decal_collection_hash
          L2_2.decalCollectionHash = L3_2
          L3_2 = A1_2.decal_name_hash
          L2_2.decalNameHash = L3_2
        end
      end
    end
  end
  return L2_2
end
ResolveClothingItemToData = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = ResolvePropItemToData
  L3_2 = A0_2
  L4_2 = {}
  L4_2.name_hash = A1_2
  return L2_2(L3_2, L4_2)
end
UsablePropHashToData = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L3_2 = {}
  L4_2 = containsDoubleDash
  L5_2 = A1_2.name_hash
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = clothingSplit
    L5_2 = A1_2.name_hash
    L6_2 = "--"
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = L4_2[1]
    L6_2 = tonumber
    L7_2 = L4_2[2]
    L6_2 = L6_2(L7_2)
    L7_2 = tonumber
    L8_2 = L4_2[3]
    L7_2 = L7_2(L8_2)
    L8_2 = tonumber
    L9_2 = L4_2[4]
    L8_2 = L8_2(L9_2)
    L9_2 = 0
    if L6_2 <= 11 then
      L10_2 = GetPedPaletteVariation
      L11_2 = A0_2
      L12_2 = L6_2
      L10_2 = L10_2(L11_2, L12_2)
      L9_2 = L10_2
    end
    L10_2 = L7_2
    if "nondlcgta5" ~= L5_2 then
      L11_2 = GetPedPropGlobalIndexFromCollection
      L12_2 = A0_2
      L13_2 = L6_2 - 100
      L14_2 = L5_2
      L15_2 = L7_2
      L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
      L10_2 = L11_2
    end
    if A2_2 then
      L3_2.componentId = L6_2
    else
      L11_2 = L6_2 - 100
      L3_2.componentId = L11_2
    end
    L3_2.drawableId = L10_2
    L3_2.textureId = L8_2
    L3_2.palette = L9_2
  else
    L4_2 = containsUnderscore
    L5_2 = A1_2.name_hash
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = mysplit
      L5_2 = A1_2.name_hash
      L6_2 = "_"
      L4_2 = L4_2(L5_2, L6_2)
      if A2_2 then
        L5_2 = compId
        L3_2.componentId = L5_2
      else
        L5_2 = tonumber
        L6_2 = L4_2[1]
        L5_2 = L5_2(L6_2)
        L5_2 = L5_2 - 100
        L3_2.componentId = L5_2
      end
      L5_2 = tonumber
      L6_2 = L4_2[2]
      L5_2 = L5_2(L6_2)
      L3_2.drawableId = L5_2
      L5_2 = tonumber
      L6_2 = L4_2[3]
      L5_2 = L5_2(L6_2)
      L3_2.textureId = L5_2
      L3_2.palette = 0
    else
      L4_2 = tonumber
      L5_2 = A1_2.name_hash
      L4_2 = L4_2(L5_2)
      L5_2 = GetShopPedProp
      L6_2 = L4_2
      L5_2 = L5_2(L6_2)
      L6_2 = L5_2.Hash
      if L6_2 then
        L6_2 = L5_2.Hash
        if 0 ~= L6_2 then
          L6_2 = L5_2.ComponentType
          L3_2.componentId = L6_2
          L6_2 = L5_2.Drawable
          L3_2.drawableId = L6_2
          L6_2 = L5_2.Texture
          L3_2.textureId = L6_2
          L3_2.palette = 0
      end
      else
        L6_2 = A1_2.component_id
        L3_2.componentId = L6_2
        L6_2 = A1_2.drawable_id
        L3_2.drawableId = L6_2
        L6_2 = A1_2.texture_id
        L3_2.textureId = L6_2
        L3_2.palette = 0
      end
    end
  end
  return L3_2
end
ResolvePropItemToData = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = ResolvePropItemToData
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2.componentId
  if L4_2 then
    L4_2 = L3_2.componentId
    if L4_2 <= 100 then
      L4_2 = L3_2.componentId
      L4_2 = L4_2 + 100
      L3_2.componentId = L4_2
    end
  end
  return L3_2
end
ResolvePropItemToDataInternalComponent = L0_1
