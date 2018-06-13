import api from './api'

const TOKEN_KEY = 'pika_token'

export async function createAccount(): Promise<string> {
  const res = await api.post('/accounts')
  if (res.err) throw res.err

  window.localStorage.setItem(TOKEN_KEY, res.body.token)

  return res.body.token
}

export async function getToken(): Promise<string> {
  let token = window.localStorage.getItem(TOKEN_KEY)
  if (token) return token
  await createAccount()
}
