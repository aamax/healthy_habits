class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'

    @user = User.find(params[:id])
    if (params[:user][:password] == "")
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if @user.update_attributes(params[:user])
      # set to admin if flag set
      if params["Administrator"].nil?
        @user.remove_role :admin
      else
        @user.add_role :admin
      end

      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."  + @user.errors.full_messages.to_sentence
    end
  end

  def new
    @newuser = User.new
  end

  def create
    @newuser = User.new(params[:user])
    if @newuser.save
      redirect_to users_path
    else
      render :new, :alert => "Error creating user: " + @newuser.errors.full_messages.to_sentence
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end