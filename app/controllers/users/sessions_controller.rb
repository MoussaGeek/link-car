class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    sign_in user
    flash[:notice] = "Connecté avec succès en tant qu'invité."
    redirect_to root_path
  end
    
  def new_admin
    user = User.admin
    sign_in user
    flash[:notice] = "Connecté avec succès en tant qu'administrateur."
    redirect_to root_path
  end
end
