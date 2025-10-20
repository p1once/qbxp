local L0_1, L1_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2)
  local L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  L9_2 = false
  L10_2 = false
  L11_2 = BACKEND_URL
  L12_2 = "/upload/"
  L13_2 = A1_2
  L14_2 = "/"
  L15_2 = A2_2
  L16_2 = "/"
  L17_2 = A3_2
  L18_2 = "/"
  L19_2 = A4_2
  L20_2 = "/"
  L21_2 = A5_2
  L22_2 = "/"
  L23_2 = A6_2
  L24_2 = "/"
  L25_2 = A7_2
  L26_2 = "/"
  L27_2 = A8_2
  L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2 .. L22_2 .. L23_2 .. L24_2 .. L25_2 .. L26_2 .. L27_2
  L12_2 = exports
  L12_2 = L12_2["screenshot-basic"]
  L13_2 = L12_2
  L12_2 = L12_2.requestScreenshotUpload
  L14_2 = L11_2
  L15_2 = "files[]"
  L16_2 = {}
  L16_2.encoding = "png"
  function L17_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L1_3 = json
    L1_3 = L1_3.decode
    L2_3 = A0_3
    L1_3 = L1_3(L2_3)
    L2_3 = L1_3.success
    L10_2 = L2_3
    L2_3 = true
    L9_2 = L2_3
    L2_3 = L10_2
    if L2_3 then
      L2_3 = TriggerServerEvent
      L3_3 = "rcore_clothing:stage2SaveResult"
      L4_3 = A0_2
      L5_3 = L1_3.url
      L6_3 = L1_3.colors
      L2_3(L3_3, L4_3, L5_3, L6_3)
    end
  end
  L12_2(L13_2, L14_2, L15_2, L16_2, L17_2)
  while not L9_2 do
    L12_2 = Wait
    L13_2 = 0
    L12_2(L13_2)
  end
  return L10_2
end
TakePhoto = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2)
  local L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L9_2 = 3
  L10_2 = false
  repeat
    L11_2 = TakePhoto
    L12_2 = A0_2
    L13_2 = A1_2
    L14_2 = A2_2
    L15_2 = A3_2
    L16_2 = A4_2
    L17_2 = A5_2
    L18_2 = A6_2
    L19_2 = A7_2
    L20_2 = A8_2
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    if L11_2 then
      L10_2 = true
      break
    else
      L9_2 = L9_2 - 1
      if L9_2 < 2 then
        L12_2 = print
        L13_2 = "No clothing item is visible on screen, it is ok - don't panic ;)."
        L14_2 = A4_2
        L15_2 = A5_2
        L16_2 = "retries left:"
        L17_2 = L9_2
        L12_2(L13_2, L14_2, L15_2, L16_2, L17_2)
        L12_2 = ShowPipelineStatusIsInvisible
        L12_2()
      end
      L12_2 = Wait
      L13_2 = 100
      L12_2(L13_2)
    end
  until L11_2 or L9_2 <= 0
  if not L10_2 then
    L11_2 = TriggerServerEvent
    L12_2 = "rcore_clothing:stage2CouldNotProcess"
    L13_2 = A0_2
    L11_2(L12_2, L13_2)
  end
end
TakePhotoWithRetry = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = false
  L2_2 = false
  L3_2 = nil
  L4_2 = nil
  L5_2 = BACKEND_URL
  L6_2 = "/upload-test/"
  L7_2 = A0_2
  L5_2 = L5_2 .. L6_2 .. L7_2
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
    L2_2 = L2_3
    L2_3 = true
    L1_2 = L2_3
    L2_3 = L2_2
    if L2_3 then
      L2_3 = L1_3.url
      L3_2 = L2_3
    else
      L2_3 = L1_3.failUrl
      L4_2 = L2_3
    end
  end
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  while not L1_2 do
    L6_2 = Wait
    L7_2 = 0
    L6_2(L7_2)
  end
  L6_2 = L3_2
  L7_2 = L4_2
  return L6_2, L7_2
end
TakePhotoWithRetryAndReturnImage = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = false
  L2_2 = false
  L3_2 = nil
  L4_2 = BACKEND_URL
  L5_2 = "/upload-test/"
  L6_2 = A0_2
  L7_2 = "?emptytest=1"
  L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
  L5_2 = exports
  L5_2 = L5_2["screenshot-basic"]
  L6_2 = L5_2
  L5_2 = L5_2.requestScreenshotUpload
  L7_2 = L4_2
  L8_2 = "files[]"
  L9_2 = {}
  L9_2.encoding = "png"
  function L10_2(A0_3)
    local L1_3, L2_3
    L1_3 = json
    L1_3 = L1_3.decode
    L2_3 = A0_3
    L1_3 = L1_3(L2_3)
    L2_3 = L1_3.success
    L2_2 = L2_3
    L2_3 = true
    L1_2 = L2_3
    L2_3 = L1_3.url
    L3_2 = L2_3
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  while not L1_2 do
    L5_2 = Wait
    L6_2 = 0
    L5_2(L6_2)
  end
  L5_2 = L2_2
  L6_2 = L3_2
  return L5_2, L6_2
end
TakePhotoEmptynessTest = L0_1
