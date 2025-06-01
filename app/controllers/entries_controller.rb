class EntriesController < ApplicationController

  def new
    @place = Place.find_by({ "id" => params["place_id"], "user_id" => session["user_id"] })
    @entry = Entry.new
  end

  def create
    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry["user_id"] = session["user_id"] #ensures the entry is connected to the logged-in user
    @entry.save
    redirect_to "/places/#{@entry["place_id"]}"
  end

end
