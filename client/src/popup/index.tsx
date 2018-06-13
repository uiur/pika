'use strict'
import { Buffer } from 'buffer'
global.Buffer = Buffer

console.log(require('buffer').Buffer)

// @ts-ignore
import * as Frisbee from 'frisbee'
import Main from './main'

import * as React from 'react'
import * as ReactDOM from 'react-dom'

ReactDOM.render(
  <Main />,
  document.getElementById("main")
)
