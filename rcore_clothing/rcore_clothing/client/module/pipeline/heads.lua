local L0_1, L1_1
L0_1 = Citizen
L0_1 = L0_1.CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2
  L0_2 = false
  do return L0_2 end
  L0_2 = GetMaleHeadBlends
  L0_2 = L0_2()
  L1_2 = GetFemaleHeadBlends
  L1_2 = L1_2()
  L2_2 = {}
  L3_2 = pairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = table
    L9_2 = L9_2.insert
    L10_2 = L2_2
    L11_2 = L8_2
    L9_2(L10_2, L11_2)
  end
  L3_2 = pairs
  L4_2 = L0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = table
    L9_2 = L9_2.insert
    L10_2 = L2_2
    L11_2 = L8_2
    L9_2(L10_2, L11_2)
  end
  L3_2 = 1885233650
  L4_2 = LoadAndSetModel
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = InvisibilityMakeInvisible
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = Wait
  L5_2 = 100
  L4_2(L5_2)
  L4_2 = SetAnim
  L4_2()
  L4_2 = Wait
  L5_2 = 2000
  L4_2(L5_2)
  L4_2 = PlayerPedId
  L4_2 = L4_2()
  L5_2 = ClothingCamSetup
  L6_2 = L4_2
  L7_2 = CAM_OFFSETS_PROCESSING
  L8_2 = 999
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = BackdropSetupForPed
  L6_2 = L4_2
  L7_2 = {}
  L8_2 = 0
  L9_2 = 255
  L10_2 = 0
  L11_2 = 255
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = pairs
  L6_2 = L2_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = 0
    L12_2 = 44
    L13_2 = 1
    for L14_2 = L11_2, L12_2, L13_2 do
      L15_2 = L10_2
      L16_2 = L14_2
      L17_2 = Wait
      L18_2 = 100
      L17_2(L18_2)
      L17_2 = SetPedHeadBlendData
      L18_2 = L4_2
      L19_2 = L15_2
      L20_2 = 0
      L21_2 = 0
      L22_2 = L16_2
      L23_2 = 0
      L24_2 = 0
      L25_2 = 0.0
      L26_2 = 0.0
      L27_2 = 0.0
      L28_2 = false
      L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
      L17_2 = Wait
      L18_2 = 200
      L17_2(L18_2)
      L17_2 = TakeHeadPhoto
      L18_2 = L3_2
      L19_2 = L15_2
      L20_2 = L16_2
      L17_2(L18_2, L19_2, L20_2)
      L17_2 = Wait
      L18_2 = 400
      L17_2(L18_2)
    end
  end
end
L0_1(L1_1)
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = false
  L4_2 = false
  L5_2 = "http://localhost:8080/upload-head/"
  L6_2 = A0_2
  L7_2 = "/"
  L8_2 = A1_2
  L9_2 = "/"
  L10_2 = A2_2
  L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
  L6_2 = print
  L7_2 = "screening"
  L8_2 = L5_2
  L6_2(L7_2, L8_2)
  L6_2 = exports
  L6_2 = L6_2["screenshot-basic"]
  L7_2 = L6_2
  L6_2 = L6_2.requestScreenshotUpload
  L8_2 = L5_2
  L9_2 = "files[]"
  L10_2 = {}
  L10_2.encoding = "png"
  function L11_2(A0_3)
    local L1_3, L2_3
    L1_3 = json
    L1_3 = L1_3.decode
    L2_3 = A0_3
    L1_3 = L1_3(L2_3)
    L2_3 = L1_3.success
    L4_2 = L2_3
    L2_3 = true
    L3_2 = L2_3
  end
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  while not L3_2 do
    L6_2 = Wait
    L7_2 = 0
    L6_2(L7_2)
  end
  return L4_2
end
TakeHeadPhoto = L0_1
