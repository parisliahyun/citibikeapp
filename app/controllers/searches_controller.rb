class SearchesController < ApplicationController

# TODO if winning_dock's available_docks == 0 within .1 miles of user's position, send notification to reroute with address to available dock.  
# change search result to p tag so it automatically becomes a link. DONE
# newsletter sign up column, boolean for user's table. 
# suggestion box
# about page.
# find a bike. 
# remove name from sign in. DONE 


  def new
    render :new
  end

  def create
    @coordinates = Geocoder.coordinates(params[:address])

    unless @coordinates.nil?
      @coordinates = { latitude: @coordinates[0], longitude: @coordinates[1] }

      citibike_docks = Citibikenyc
                        .stations
                        .values[2]
                        .reject { |d| d["availableDocks"] == 0 }

      @winning_dock = citibike_docks.min_by do |dock|
        distance_x = @coordinates[:longitude] - dock["longitude"]
        distance_y = @coordinates[:latitude] - dock["latitude"]
        Math.hypot( distance_x, distance_y )
      end 
      render :results
    else
      render erb: "<%= debug Geocoder.coordinates(params[:address]) %>"
    end
  end

end