local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1
L0_1 = string
L0_1 = L0_1.blob
if not L0_1 then
  function L0_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = string
    L1_2 = L1_2.rep
    L2_2 = "\000"
    L3_2 = math
    L3_2 = L3_2.max
    L4_2 = 41
    L5_2 = A0_2
    L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
    return L1_2(L2_2, L3_2, L4_2, L5_2)
  end
end
L1_1 = {}
L1_1.EndBig = ">"
L1_1.EndLittle = "<"
L2_1 = {}
L3_1 = {}
L3_1.code = "i1"
L3_1.size = 1
L2_1.Int8 = L3_1
L3_1 = {}
L3_1.code = "I1"
L3_1.size = 1
L2_1.Uint8 = L3_1
L3_1 = {}
L3_1.code = "i2"
L3_1.size = 2
L2_1.Int16 = L3_1
L3_1 = {}
L3_1.code = "I2"
L3_1.size = 2
L2_1.Uint16 = L3_1
L3_1 = {}
L3_1.code = "i4"
L3_1.size = 4
L2_1.Int32 = L3_1
L3_1 = {}
L3_1.code = "I4"
L3_1.size = 4
L2_1.Uint32 = L3_1
L3_1 = {}
L3_1.code = "i8"
L3_1.size = 8
L2_1.Int64 = L3_1
L3_1 = {}
L3_1.code = "I8"
L3_1.size = 8
L2_1.Uint64 = L3_1
L3_1 = {}
L3_1.code = "j"
L3_1.size = 8
L2_1.LuaInt = L3_1
L3_1 = {}
L3_1.code = "J"
L3_1.size = 8
L2_1.UluaInt = L3_1
L3_1 = {}
L3_1.code = "n"
L3_1.size = 8
L2_1.LuaNum = L3_1
L3_1 = {}
L3_1.code = "f"
L3_1.size = 4
L2_1.Float32 = L3_1
L3_1 = {}
L3_1.code = "d"
L3_1.size = 8
L2_1.Float64 = L3_1
L3_1 = {}
L3_1.code = "z"
L3_1.size = -1
L2_1.String = L3_1
L1_1.Types = L2_1
L2_1 = {}
L3_1 = {}
L3_1.code = "c"
L3_1.size = -1
L2_1.String = L3_1
L3_1 = {}
L3_1.code = "i"
L3_1.size = -1
L2_1.Int = L3_1
L3_1 = {}
L3_1.code = "I"
L3_1.size = -1
L2_1.Uint = L3_1
L1_1.FixedTypes = L2_1
DataView = L1_1
L1_1 = DataView
L2_1 = DataView
L1_1.__index = L2_1
function L1_1(A0_2, A1_2, A2_2)
  local L3_2
  L3_2 = A2_2.size
  if L3_2 < 0 then
    L3_2 = true
    if L3_2 then
      goto lbl_16
    end
  end
  L3_2 = A2_2.size
  L3_2 = L3_2 - 1
  L3_2 = A0_2 + L3_2
  L3_2 = A1_2 >= L3_2
  ::lbl_16::
  return L3_2
end
function L2_1(A0_2)
  local L1_2
  if A0_2 then
    L1_2 = DataView
    L1_2 = L1_2.EndBig
    if L1_2 then
      goto lbl_9
    end
  end
  L1_2 = DataView
  L1_2 = L1_2.EndLittle
  ::lbl_9::
  return L1_2
end
L3_1 = nil
L4_1 = DataView
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = setmetatable
  L2_2 = {}
  L2_2.offset = 1
  L2_2.length = A0_2
  L3_2 = L0_1
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L2_2.blob = L3_2
  L3_2 = DataView
  return L1_2(L2_2, L3_2)
end
L4_1.ArrayBuffer = L5_1
L4_1 = DataView
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = setmetatable
  L2_2 = {}
  L2_2.offset = 1
  L2_2.blob = A0_2
  L4_2 = A0_2
  L3_2 = A0_2.len
  L3_2 = L3_2(L4_2)
  L2_2.length = L3_2
  L3_2 = DataView
  return L1_2(L2_2, L3_2)
end
L4_1.Wrap = L5_1
L4_1 = DataView
function L5_1(A0_2)
  local L1_2
  L1_2 = A0_2.blob
  return L1_2
end
L4_1.Buffer = L5_1
L4_1 = DataView
function L5_1(A0_2)
  local L1_2
  L1_2 = A0_2.length
  return L1_2
end
L4_1.ByteLength = L5_1
L4_1 = DataView
function L5_1(A0_2)
  local L1_2
  L1_2 = A0_2.offset
  return L1_2
end
L4_1.ByteOffset = L5_1
L4_1 = DataView
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = setmetatable
  L3_2 = {}
  L3_2.offset = A1_2
  L4_2 = A0_2.blob
  L3_2.blob = L4_2
  L4_2 = A0_2.length
  L3_2.length = L4_2
  L4_2 = DataView
  return L2_2(L3_2, L4_2)
end
L4_1.SubView = L5_1
L4_1 = pairs
L5_1 = DataView
L5_1 = L5_1.Types
L4_1, L5_1, L6_1, L7_1 = L4_1(L5_1)
for L8_1, L9_1 in L4_1, L5_1, L6_1, L7_1 do
  L10_1 = DataView
  L11_1 = "Get"
  L12_1 = L8_1
  L11_1 = L11_1 .. L12_1
  function L12_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2
    L3_2 = A0_2.offset
    L3_2 = L3_2 + A1_2
    L4_2 = L1_1
    L5_2 = L3_2
    L6_2 = A0_2.length
    L7_2 = L9_1
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    if L4_2 then
      L4_2 = string
      L4_2 = L4_2.unpack
      L5_2 = L2_1
      L6_2 = A2_2
      L5_2 = L5_2(L6_2)
      L6_2 = L9_1.code
      L5_2 = L5_2 .. L6_2
      L6_2 = A0_2.blob
      L7_2 = L3_2
      L4_2, L5_2 = L4_2(L5_2, L6_2, L7_2)
      return L4_2
    end
    L4_2 = nil
    return L4_2
  end
  L10_1[L11_1] = L12_1
  L10_1 = DataView
  L11_1 = "Set"
  L12_1 = L8_1
  L11_1 = L11_1 .. L12_1
  function L12_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L4_2 = A0_2.offset
    L4_2 = L4_2 + A1_2
    L5_2 = L1_1
    L6_2 = L4_2
    L7_2 = A0_2.length
    L8_2 = L9_1
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    if L5_2 then
      L5_2 = L3_1
      L6_2 = A0_2
      L7_2 = L4_2
      L8_2 = A2_2
      L9_2 = L2_1
      L10_2 = A3_2
      L9_2 = L9_2(L10_2)
      L10_2 = L9_1.code
      L9_2 = L9_2 .. L10_2
      return L5_2(L6_2, L7_2, L8_2, L9_2)
    end
    return A0_2
  end
  L10_1[L11_1] = L12_1
  L10_1 = L9_1.size
  if L10_1 >= 0 then
    L10_1 = string
    L10_1 = L10_1.packsize
    L11_1 = L9_1.code
    L10_1 = L10_1(L11_1)
    L11_1 = L9_1.size
    if L10_1 ~= L11_1 then
      L10_1 = "Pack size of %s (%d) does not match cached length: (%d)"
      L11_1 = error
      L13_1 = L10_1
      L12_1 = L10_1.format
      L14_1 = L8_1
      L15_1 = string
      L15_1 = L15_1.packsize
      L16_1 = fmt
      L17_1 = fmt
      L17_1 = #L17_1
      L16_1 = L16_1[L17_1]
      L15_1 = L15_1(L16_1)
      L16_1 = L9_1.size
      L12_1, L13_1, L14_1, L15_1, L16_1, L17_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
      L11_1(L12_1, L13_1, L14_1, L15_1, L16_1, L17_1)
      L11_1 = nil
      return L11_1
    end
  end
end
L4_1 = pairs
L5_1 = DataView
L5_1 = L5_1.FixedTypes
L4_1, L5_1, L6_1, L7_1 = L4_1(L5_1)
for L8_1, L9_1 in L4_1, L5_1, L6_1, L7_1 do
  L10_1 = DataView
  L11_1 = "GetFixed"
  L12_1 = L8_1
  L11_1 = L11_1 .. L12_1
  function L12_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L4_2 = A0_2.offset
    L4_2 = L4_2 + A1_2
    L5_2 = A2_2 - 1
    L5_2 = L4_2 + L5_2
    L6_2 = A0_2.length
    if L5_2 <= L6_2 then
      L5_2 = L2_1
      L6_2 = A3_2
      L5_2 = L5_2(L6_2)
      L6_2 = "c"
      L7_2 = tostring
      L8_2 = A2_2
      L7_2 = L7_2(L8_2)
      L5_2 = L5_2 .. L6_2 .. L7_2
      L6_2 = string
      L6_2 = L6_2.unpack
      L7_2 = L5_2
      L8_2 = A0_2.blob
      L9_2 = L4_2
      L6_2, L7_2 = L6_2(L7_2, L8_2, L9_2)
      return L6_2
    end
    L5_2 = nil
    return L5_2
  end
  L10_1[L11_1] = L12_1
  L10_1 = DataView
  L11_1 = "SetFixed"
  L12_1 = L8_1
  L11_1 = L11_1 .. L12_1
  function L12_1(A0_2, A1_2, A2_2, A3_2, A4_2)
    local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L5_2 = A0_2.offset
    L5_2 = L5_2 + A1_2
    L6_2 = A2_2 - 1
    L6_2 = L5_2 + L6_2
    L7_2 = A0_2.length
    if L6_2 <= L7_2 then
      L6_2 = L2_1
      L7_2 = A4_2
      L6_2 = L6_2(L7_2)
      L7_2 = "c"
      L8_2 = tostring
      L9_2 = A2_2
      L8_2 = L8_2(L9_2)
      L6_2 = L6_2 .. L7_2 .. L8_2
      L7_2 = L3_1
      L8_2 = A0_2
      L9_2 = L5_2
      L10_2 = A3_2
      L11_2 = L6_2
      return L7_2(L8_2, L9_2, L10_2, L11_2)
    end
    return A0_2
  end
  L10_1[L11_1] = L12_1
end
function L4_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L4_2 = {}
  L5_2 = {}
  L6_2 = A0_2.offset
  if A1_2 > L6_2 then
    L6_2 = A0_2.offset
    L6_2 = A1_2 - L6_2
    L7_2 = #L4_2
    L7_2 = L7_2 + 1
    L8_2 = "c"
    L9_2 = tostring
    L10_2 = L6_2
    L9_2 = L9_2(L10_2)
    L8_2 = L8_2 .. L9_2
    L4_2[L7_2] = L8_2
    L7_2 = #L5_2
    L7_2 = L7_2 + 1
    L8_2 = A0_2.blob
    L9_2 = L8_2
    L8_2 = L8_2.sub
    L10_2 = A0_2.offset
    L11_2 = L6_2
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L5_2[L7_2] = L8_2
  end
  L6_2 = #L4_2
  L6_2 = L6_2 + 1
  L4_2[L6_2] = A3_2
  L6_2 = #L5_2
  L6_2 = L6_2 + 1
  L5_2[L6_2] = A2_2
  L6_2 = string
  L6_2 = L6_2.packsize
  L7_2 = #L4_2
  L7_2 = L4_2[L7_2]
  L6_2 = L6_2(L7_2)
  L7_2 = A1_2 + L6_2
  L8_2 = A0_2.length
  if L7_2 <= L8_2 then
    L7_2 = A1_2 + L6_2
    L8_2 = A0_2.length
    L8_2 = L8_2 - L7_2
    L8_2 = L8_2 + 1
    L9_2 = #L4_2
    L9_2 = L9_2 + 1
    L10_2 = "c"
    L11_2 = tostring
    L12_2 = L8_2
    L11_2 = L11_2(L12_2)
    L10_2 = L10_2 .. L11_2
    L4_2[L9_2] = L10_2
    L9_2 = #L5_2
    L9_2 = L9_2 + 1
    L10_2 = A0_2.blob
    L11_2 = L10_2
    L10_2 = L10_2.sub
    L12_2 = L7_2
    L13_2 = L8_2
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L5_2[L9_2] = L10_2
  end
  L7_2 = string
  L7_2 = L7_2.pack
  L8_2 = table
  L8_2 = L8_2.concat
  L9_2 = L4_2
  L10_2 = ""
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = table
  L9_2 = L9_2.unpack
  L10_2 = L5_2
  L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2)
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  A0_2.blob = L7_2
  L7_2 = A0_2.blob
  L8_2 = L7_2
  L7_2 = L7_2.len
  L7_2 = L7_2(L8_2)
  A0_2.length = L7_2
  return A0_2
end
L3_1 = L4_1
L4_1 = {}
DataStream = L4_1
L4_1 = DataStream
L5_1 = DataStream
L4_1.__index = L5_1
L4_1 = DataStream
function L5_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = setmetatable
  L2_2 = {}
  L2_2.view = A0_2
  L2_2.offset = 0
  L3_2 = DataStream
  return L1_2(L2_2, L3_2)
end
L4_1.New = L5_1
L4_1 = pairs
L5_1 = DataView
L5_1 = L5_1.Types
L4_1, L5_1, L6_1, L7_1 = L4_1(L5_1)
for L8_1, L9_1 in L4_1, L5_1, L6_1, L7_1 do
  L10_1 = DataStream
  function L11_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L3_2 = A0_2.offset
    L4_2 = A0_2.view
    L4_2 = L4_2.offset
    L3_2 = L3_2 + L4_2
    L4_2 = L1_1
    L5_2 = L3_2
    L6_2 = A0_2.view
    L6_2 = L6_2.length
    L7_2 = L9_1
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    if not L4_2 then
      L4_2 = nil
      return L4_2
    end
    L4_2 = string
    L4_2 = L4_2.unpack
    L5_2 = L2_1
    L6_2 = A1_2
    L5_2 = L5_2(L6_2)
    L6_2 = L9_1.code
    L5_2 = L5_2 .. L6_2
    L6_2 = A0_2.view
    L7_2 = L6_2
    L6_2 = L6_2.Buffer
    L6_2 = L6_2(L7_2)
    L7_2 = L3_2
    L4_2, L5_2 = L4_2(L5_2, L6_2, L7_2)
    if A2_2 then
      L6_2 = A0_2.offset
      L7_2 = math
      L7_2 = L7_2.max
      L8_2 = L5_2 - L3_2
      L9_2 = A2_2
      L7_2 = L7_2(L8_2, L9_2)
      L6_2 = L6_2 + L7_2
      A0_2.offset = L6_2
    else
      L6_2 = A0_2.view
      L6_2 = L6_2.offset
      L6_2 = L5_2 - L6_2
      A0_2.offset = L6_2
    end
    return L4_2
  end
  L10_1[L8_1] = L11_1
end
function L4_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  if not A1_2 then
    A1_2 = 0
  end
  L2_2 = type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "table" == L2_2 then
    L2_2 = pairs
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = string
      L8_2 = L8_2.rep
      L9_2 = "  "
      L10_2 = A1_2
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = L6_2
      L10_2 = ": "
      L8_2 = L8_2 .. L9_2 .. L10_2
      formatting = L8_2
      L8_2 = type
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if "table" == L8_2 then
        L8_2 = print
        L9_2 = formatting
        L8_2(L9_2)
        L8_2 = tprint
        L9_2 = L7_2
        L10_2 = A1_2 + 1
        L8_2(L9_2, L10_2)
      else
        L8_2 = type
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if "boolean" == L8_2 then
          L8_2 = print
          L9_2 = formatting
          L10_2 = tostring
          L11_2 = L7_2
          L10_2 = L10_2(L11_2)
          L9_2 = L9_2 .. L10_2
          L8_2(L9_2)
        else
          L8_2 = print
          L9_2 = formatting
          L10_2 = L7_2
          L9_2 = L9_2 .. L10_2
          L8_2(L9_2)
        end
      end
    end
  else
    L2_2 = print
    L3_2 = A0_2
    L2_2(L3_2)
  end
end
tprint = L4_1
