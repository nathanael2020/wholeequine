 Spree::UsersController.class_eval do
   def info
     @user = current_user
     render layout: false
   end

   def update
     if @user.update_attributes(params[:user])
       if params[:user][:password].present?
         # this logic needed b/c devise wants to log us out after password changes
         user = Spree::User.reset_password_by_token(params[:user])
         sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
       end
       respond_to do |format|
         format.html{ redirect_to spree.account_url, :notice => t(:account_updated)  }
         format.js{
           flash.notice = t(:account_updated)
         }
       end

     else
       respond_to do |format|
         format.html{ render :edit }
         format.js{ }
       end

     end
   end
 end
