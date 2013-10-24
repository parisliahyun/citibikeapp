class SearchesController < ApplicationController

# TODO if winning_dock's available_docks == 0 within .1 miles of user's position, send notification to reroute with address to available dock.  
# change search result to p tag so it automatically becomes a link.
# newsletter sign up column, boolean for user's table. 
# suggestion box
# about page.
# find a bike. DONE
# add map it functionality, just a link.
# review account route and about route make sure it's in the right view. DONE   


  def new
    render :new
  end

  def create
    @coordinates = Geocoder.coordinates(params[:address])
    @dock = params[:dock] == "Find me a dock"
    
    unless @coordinates.nil?
      @coordinates = { latitude: @coordinates[0], longitude: @coordinates[1] }

      all_citibike_stations = Citibikenyc.stations.values[2]
      if @dock  
        available_stations = all_citibike_stations.reject { |d| d["availableDocks"] == 0 }
      else
        available_stations = all_citibike_stations.reject { |d| d["availableBikes"] == 0 }
      end  
      @winning_station = available_stations.min_by do |station|
        distance_x = @coordinates[:longitude] - station["longitude"]
        distance_y = @coordinates[:latitude] - station["latitude"]
        Math.hypot( distance_x, distance_y )
      end 
      render :results
    else
      render erb: "<%= debug Geocoder.coordinates(params[:address]) %>"
    end
  end

end