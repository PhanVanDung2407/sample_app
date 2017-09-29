class SessionsController < ApplicationController
  def new; end

  def remember_user
    user = User.find_by email: params[:session][:email].downcase
    params[:session][:remember_me] == Settings.session ? remember(user) : forget(user)
  end

  def action
    log_in user
    remember_user
    redirect_back_or user
  end

  def check
    user = User.find_by email: params[:session][:email].downcase
    if user.activated?
      action
    else
      message  = t ".account"
      message += t ".check"
      flash[:warning] = message
      redirect_to root_url
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      check
    else
      flash.now[:danger] = I18n.t(".users.new.invalid_email_password")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
