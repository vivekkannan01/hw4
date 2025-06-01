class UsersController < ApplicationController
  def new
    # if someone is already logged in, don't show signup
    if @current_user
      redirect_to "/places"
    end
  end

  def create

    existing_email = User.find_by({ "email" => params["email"] })
    existing_username = User.find_by({ "username" => params["username"] })

    if existing_email
      flash["notice"] = "Email already taken"
      redirect_to "/users/new"
    
    elsif existing_username
      flash["notice"] = "Username already taken"
      redirect_to "/users/new"
    
    else
      @user = User.new
      @user["username"] = params["username"]
      @user["email"] = params["email"]
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save

      # Optionally log the user in right after signup:
      session["user_id"] = @user["id"]
      redirect_to "/places"
    end
  end

end
