class NewsletterController < ApplicationController
  def subscribe
    @newsletter_user = Spree::User.new({
                                            email: params[:email],
                                            password: "password123",
                                            password_confirmation: "password123",
                                            newsletter: true
                                      })
    if @newsletter_user.save
      redirect_to :back, :notice => "Thank you."
    else
      redirect_to :back, :notice => @newsletter_user.errors.full_messages.join(", ")
    end

  end
end
