port = chrome.extension.connect name: 'dexkcd'

allImgs = document.getElementsByTagName 'img'

port.onMessage.addListener (msg) ->
  if msg.index? and msg.action?
    if msg.action == 'destroy'
      img = allImgs[msg.index]
      h = img.height
      w = img.width
      img.src = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAABSSURBVHjaYvz//z8DOQAggJgYyAQAAUS2RoAAIlsjQACRrREggMjWCBBAZGsECCCyNQIEENkaAQKIbI0AAUS2RoAAIlsjQACRrREggMjWCBBgAHn1AxllYnenAAAAAElFTkSuQmCC'
      img.height = h
      img.width = w

requestCheck = (index, img) ->
  port.postMessage "action": 'checkImage', "src": img.src, "index": index

for i in [0..allImgs.length]
  if allImgs[i]?
      requestCheck i, allImgs[i]
