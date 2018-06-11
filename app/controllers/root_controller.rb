class RootController < ApplicationController
  def index
    render json: 'hello'
  end
end
