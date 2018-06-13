import api from '../lib/api'
import { getToken } from '../lib/client'

chrome.runtime.onMessage.addListener(async function (request: any, sender: any, sendResponse: any) {
  const token = await getToken()

  const res = await api.jwt(token).post('/payments', {
    body: {
      payment_request: request.invoice
    }
  })

  if (res.err) throw res.err

  sendResponse({hello: "goodbye"})
})
