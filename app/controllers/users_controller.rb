class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :only_admin, except: %i[ show ]
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.page(params[:page])
  end

  def show
      @user = current_user
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "L'utilisateur a été modifier avec succès"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "L'utilisateur a été supprimer avec succès." }
      format.json { head :no_content }
    end
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
      @user = User.find(params[:id])
  end

  def only_admin
    redirect_to root_path unless current_user&.admin?
  end
end