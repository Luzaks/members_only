class SessionsController < ApplicationController

  def new
  end


  def create
    @email = params[:sessions][:email]     
    user = User.find_by_email(@email.downcase)   
    if user && user.authenticate(params[:sessions][:password])   
      flash[:success] = "successfully signed in"    
      sign_in user    
      #redirect_to root_path   
    else 
      flash.now[:danger] = "no user found"   
      render 'new'     
    end 
  end
end
