// @ts-ignore
import * as Frisbee from 'frisbee'

export default new Frisbee({
  baseURI: 'http://localhost:3000',
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  }
})
