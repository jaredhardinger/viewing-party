# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
        flash[:success] = "Welcome, #{@user.name}!"
    else
      redirect_to register_path, alert: @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
