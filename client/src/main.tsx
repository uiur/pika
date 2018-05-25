import * as React from 'react'
import * as ReactDOM from 'react-dom'
import api from './api'

interface State {
  balance: number,
  paymentRequest: string
}

export default class Main extends React.Component<{}, State> {
  constructor (props: {}) {
    super(props)

    this.state = {
      balance: 0,
      paymentRequest: ''
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

  async onClick () {
    const res = await api.post('/payments', {
      body: {
        payment_request: this.state.paymentRequest
      }
    })

    if (res.err) throw res.err
  }

  onChange (e: any) {
    this.setState({
      paymentRequest: e.target.value
    })
  }

  render () {
    return (
      <div>
        <p>{ this.state.balance }</p>
        <input type='text' placeholder='payment request' onChange={ this.onChange.bind(this) } />
        <button onClick={ this.onClick.bind(this) }>pay</button>
      </div>
    )
  }
}
