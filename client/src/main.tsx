import * as React from 'react'
import * as ReactDOM from 'react-dom'
import api from './api'

const SATOSHI = 100 * 1000 * 1000
const JPY_BTC = 807793

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

    this.setState({ balance: 0.02 * SATOSHI || res.body.balance })
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

        <div className='head'>
          <div className='balance'>
            ¥{ Math.floor(JPY_BTC * (this.state.balance / SATOSHI)) }
          </div>

          <div className='balance-btc'>
            { this.state.balance / SATOSHI } BTC
          </div>
        </div>

        <div className='container'>
          <div className='row menu'>
            <div className='col-4 menu-item active'>
              送る
            </div>
            <div className='col-4 menu-item'>
              受け取る
            </div>
            <div className='col-4 menu-item'>
              履歴
            </div>
          </div>
        </div>

        <div className='container'>
          <form className='form-pay'>
            <div className='form-group'>
              <label>送金コード</label>
              <input type='text' className='form-control' placeholder='ln...' onChange={ this.onChange.bind(this) } />
            </div>

            <button type='button' className='btn btn-primary btn-block btn-lg btn-pay' onClick={ this.onClick.bind(this) }>送金する</button>
          </form>
        </div>
      </div>
    )
  }
}