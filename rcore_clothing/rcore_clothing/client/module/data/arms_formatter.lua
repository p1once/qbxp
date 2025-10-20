local L0_1, L1_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  if A0_2 > 0 then
    L1_2 = {}
    return L1_2
  end
  L1_2 = {}
  L2_2 = GetShopPed
  L2_2 = L2_2()
  if not L2_2 then
    L2_2 = PlayerPedId
    L2_2 = L2_2()
  end
  L3_2 = GetEntityModel
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = pairs
  L5_2 = DataGetArms
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L5_2()
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = UsableHashToData
    L11_2 = L2_2
    L12_2 = L9_2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = L9_2
    L12_2 = L11_2
    L13_2 = "_0"
    L14_2 = "_0"
    L12_2 = L12_2 .. L13_2 .. L14_2
    L11_2 = L12_2
    L12_2 = table
    L12_2 = L12_2.insert
    L13_2 = L1_2
    L14_2 = {}
    L14_2.type = "clothing_item"
    L14_2.subtype = "base_arms"
    L14_2.id = L8_2
    L14_2.label = ""
    L14_2.price = nil
    L15_2 = L10_2.drawableId
    L14_2.drawable_id = L15_2
    L15_2 = L10_2.textureId
    L14_2.texture_id = L15_2
    L15_2 = "https://clothing.rcore.cz/assets/gamedata/"
    L16_2 = L3_2
    L17_2 = "/3/"
    L18_2 = L11_2
    L19_2 = ".webp"
    L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2
    L14_2.image = L15_2
    L14_2.colors = ""
    L14_2.category = ""
    L14_2.name_hash = L9_2
    L14_2.component_id = 3
    L14_2.decal_collection_hash = nil
    L14_2.decal_name_hash = nil
    L12_2(L13_2, L14_2)
  end
  return L1_2
end
QueryAvailableArms = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  if A0_2 > 0 then
    L1_2 = {}
    return L1_2
  end
  L1_2 = {}
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = GetEntityModel
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetPedDrawableVariation
  L5_2 = L2_2
  L6_2 = 3
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = GetPedTextureVariation
  L6_2 = L2_2
  L7_2 = 3
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = GetHashNameForComponent
  L7_2 = L2_2
  L8_2 = 3
  L9_2 = L4_2
  L10_2 = L5_2
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = GetUsableHash
  L8_2 = 3
  L9_2 = L4_2
  L10_2 = L5_2
  L11_2 = L6_2
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = GetBaseArmsFromHash
  L9_2 = L7_2
  L8_2, L9_2 = L8_2(L9_2)
  L10_2 = GetAvailableGloves
  L11_2 = L9_2
  L10_2 = L10_2(L11_2)
  L11_2 = pairs
  L12_2 = L10_2
  L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
  for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
    L17_2 = UsableHashToData
    L18_2 = L2_2
    L19_2 = L16_2
    L17_2 = L17_2(L18_2, L19_2)
    L18_2 = L16_2
    L19_2 = L18_2
    L20_2 = "_0"
    L21_2 = "_0"
    L19_2 = L19_2 .. L20_2 .. L21_2
    L18_2 = L19_2
    L19_2 = table
    L19_2 = L19_2.insert
    L20_2 = L1_2
    L21_2 = {}
    L21_2.type = "clothing_item"
    L22_2 = 1000000 + L15_2
    L21_2.id = L22_2
    L21_2.gloves = true
    L21_2.label = ""
    L21_2.price = nil
    L22_2 = L17_2.drawableId
    L21_2.drawable_id = L22_2
    L22_2 = L17_2.textureId
    L21_2.texture_id = L22_2
    L22_2 = "https://clothing.rcore.cz/assets/gamedata/"
    L23_2 = L3_2
    L24_2 = "/3/"
    L25_2 = L18_2
    L26_2 = ".webp"
    L22_2 = L22_2 .. L23_2 .. L24_2 .. L25_2 .. L26_2
    L21_2.image = L22_2
    L21_2.colors = ""
    L21_2.category = ""
    L21_2.name_hash = L16_2
    L21_2.component_id = 3
    L21_2.decal_collection_hash = nil
    L21_2.decal_name_hash = nil
    L19_2(L20_2, L21_2)
  end
  return L1_2
end
QueryAvailableGloves = L0_1
