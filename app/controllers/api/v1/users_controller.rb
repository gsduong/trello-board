class Api::V1::UsersController < ApplicationController
  before_action :require_login, :only => [:index]

  def index
    search = params[:term]
    users = User.where('email LIKE?', "%#{search.downcase}%")
    render :json => users
  end
end
