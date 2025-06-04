class UsersController < ApplicationController
  def new
    # if someone is already logged in, don't show signup
    if @current_user
      redirect_to "/places"
    end
  end

  def create
    existing_user = User.find_by({ "email" => params["email"] })
    if existing_user
      flash["notice"] = "Email already taken"
      redirect_to "/users/new"
    else
      @user = User.new
      @user["username"] = params["username"]
      @user["email"] = params["email"]
      @user["password"] = BCrypt::Password.create(params["password"])
      @user.save
      session["user_id"] = @user["id"]
      redirect_to "/places"
    end
  end

end
