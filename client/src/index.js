'use strict'

import Frisbee from 'frisbee'
import './main.jsx'

const api = new Frisbee({
  baseURI: 'http://localhost:3000'
})

async function main () {
  const res = await api.get('/wallet')
  console.log(JSON.stringify(res.body))
}

main()
