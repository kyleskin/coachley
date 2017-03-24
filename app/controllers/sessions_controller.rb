class SessionsController < ApplicationController

  def new
  end

  def user_type(user)
    @user_type = @user.type
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      user_type(@user)
      case @user_type
      when 'Admin'
        redirect_to admins_path
      when 'Manager'
        redirect_to managers_path
      when 'Coach'
        redirect_to coaches_path
      when 'Rep'
        redirect_to reps_path
      end
    else
      flash.now[:danger] = "invalid information"
      render 'new'
    end
  end

  def destroy
  end
end
