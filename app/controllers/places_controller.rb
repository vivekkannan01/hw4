class PlacesController < ApplicationController

  def index
    if @current_user
      @places = Place.where({ "user_id" => @current_user["id"] })
    else
      redirect_to "/login", notice: "Please log in to continue."
    end
  end

  def show
    @place = Place.find_by({ "id" => params["id"], "user_id" => @current_user["id"] })

    # Only show entries for this place that belong to the current user
    if @place
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @current_user["id"] })
    else
      redirect_to "/places", notice: "Place not found or access denied."
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place["user_id"] = @current_user["id"]
    @place.save
    redirect_to "/places"
  end

end