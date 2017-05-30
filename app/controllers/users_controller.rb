class UsersController < ApplicationController
  before_action :require_login, :only => [:show]
  before_action :correct_user, :only => [:show]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in  @user
      flash[:success] = 'Welcome to the Trello App!'
      redirect_to root_url
    else
      render 'new'
    end
  end

  private # permit only 3 fields, not other fields

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
