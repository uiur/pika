chrome.runtime.onMessage.addListener(
  function(request: any, sender: any, sendResponse: any) {
    console.log(request)
    sendResponse({hello: "goodbye"});
})
