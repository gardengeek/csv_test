class AccountsController < ApplicationController
  ssl_required :new, :create, :edit, :update
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :authorize, :except => [:new, :create]

  def new
    @user = User.new(params)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Instructions to confirm your account have been emailed to you. Please check your email."
      redirect_to sign_in_url
    else
      render :action => :new
    end
  end

  def show
    @user = current_user
    render "shared/user"
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def destroy
    @user = current_user
    @user.cancel

    flash[:info] = "Account canceled. We're sorry to see you go."

    respond_to do |format|
      format.html { redirect_to(:action => :new) }
      format.xml  { head :ok }
    end
  end
end
