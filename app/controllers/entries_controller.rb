class EntriesController < ApplicationController

  def new
    @place = Place.find_by({ "id" => params["place_id"], "user_id" => session["user_id"] })
    @entry = Entry.new
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["image"] = params["image"]
      @entry["user_id"] = @user["id"]
      @entry.save
      @entry.uploaded_image.attach(params["uploaded_image"]) if params["uploaded_image"]
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/places/#{params["place_id"]}"
  end

end
