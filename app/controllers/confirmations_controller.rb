class ConfirmationsController < ApplicationController
  before_filter :require_no_user

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_account_confirmation_instructions!
      flash[:notice] = "Instructions to confirm your account have been emailed to you. Please check your email."
      redirect_to sign_in_url
    else
      flash[:error] = "No user was found with that email address"
      render :action => :new
    end
  end

  def edit
    @user = User.find_by_confirmation_token(params[:id])

    if @user && !@user.confirmed?
      @user.update_attribute(:confirmed_at,Time.now)
      sign_in(@user)
      flash[:success] = "Account Confirmed"
      redirect_to account_path
    elsif @user && @user.confirmed?
      flash[:error] = "That account has already been confirmed!"
      redirect_to new_account_path
    else
      flash[:notice] = "We're sorry, but that link is invalid or expired. Please try again."
      redirect_to :action => :new
    end
  end
end
