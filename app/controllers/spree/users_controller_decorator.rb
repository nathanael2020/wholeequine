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
     
        def new_address
     @user = spree_current_user
     pos = (params[:address_count]|| @user.addresses.size).to_i + 1
     @address = Spree::Address.default
     @address.position = pos

     respond_to do |format|
       format.html{ redirect_to new_address_path }
       format.js{ render :partial => "address", :layout => false, :locals => {:addr => @address, :index => pos } }
     end

   end

   def create_address
     @user = spree_current_user
     @address = Spree::Address.new(params[:address])
     @address.user = @user
     if @address.save
       flash[:notice] = I18n.t(:successfully_created, :resource => I18n.t(:address))
       redirect_to spree.account_url
     else
       render :action => "show"
     end

   end

   def destroy_address
     @address = spree_current_user.addresses.find(params[:id])
     @address.destroy
     flash[:notice] = I18n.t(:successfully_removed, :resource => t(:address))
     redirect_to spree.account_url
   end

   def update_address
     @user = spree_current_user
     @address = spree_current_user.addresses.find(params[:id])

     if @address.editable?
       if @address.update_attributes(params[:address])
         flash[:notice] = I18n.t(:successfully_updated, :resource => I18n.t(:address))
         redirect_to spree.account_url
       else
         render :action => "show"
       end
     else
       new_address = @address.clone
       new_address.attributes = params[:address]
       @address.update_attribute(:deleted_at, Time.now)
       if new_address.save
         flash[:notice] = I18n.t(:successfully_updated, :resource => I18n.t(:address))
         redirect_to spree.account_url
       else
         render :action => "show"
       end
     end

   end
 end
