class UsersController < ApplicationController
  def index
    @user = User.order(id: :desc).per(10)
  end

  def new
  end

end
