Spree::UserRegistrationsController.class_eval do
  # POST /resource/sign_up
  def create
    @user = build_resource(params[:user])
    if resource.save
      set_flash_message(:notice, :signed_up)
      sign_in(:user, @user)
      session[:spree_user_signup] = true
      session[:show_popup_user_info] = true
      associate_user
      sign_in_and_redirect(:user, @user)
    else
      clean_up_passwords(resource)
      render :new
    end
  end


end
