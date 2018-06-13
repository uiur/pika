declare var chrome: any

document.addEventListener('click', (e) => {
  if (e.target && (<Element> e.target).nodeName == 'A') {
    const href = (<Element> e.target).getAttribute('href')

    if ((/^lightning:/).test(href)) {
      e.preventDefault()
      const invoice = href.replace(/^lightning:/, '')
      chrome.runtime.sendMessage({invoice: invoice}, function(response: any) {
        console.log(response);
      });
    }
  }
})
