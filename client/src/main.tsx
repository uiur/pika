import * as React from 'react'
import * as ReactDOM from 'react-dom'
import api from './api'

interface State {
  balance: number
}

export default class Main extends React.Component<{}, State> {
  constructor (props: {}) {
    super(props)

    this.state = {
      balance: 0
    }
  }

  componentDidMount () {
    this.start()
  }

  async start () {
    const res = await api.get('/wallet')
    if (res.err) throw res.err

    this.setState({ balance: res.body.balance })
  }

  render () {
    return (
      <div>{ this.state.balance }</div>
    )
  }
}
