class AdminsController < ApplicationController
  before_action :get_users, only:[:dashboard]

  def dashboard

  end


  private

  def get_users
    @users = User.all
  end
end
