class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    intercom_shutdown unless @user == current_user
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  protected

  def intercom_shutdown
    binding.pry
    IntercomRails::ShutdownHelper.intercom_shutdown(session, cookies)
    binding.pry
  end

end
