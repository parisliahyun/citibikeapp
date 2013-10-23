class SearchesController < ApplicationController

#  double check the logic - don't think it's returning shortest distance. DONE
# if available_docks == 0, exclude station from results. IN PROGRESS
# if winning_dock's available_docks == 0 within .1 miles of user's position, send notification to reroute with address to available dock. 

  def index
    @address = Favorite.new(address: params[:address])
    @coordinates = Geocoder.coordinates(params[:address])

    unless @coordinates.nil?

      @coordinates = { "latitude" => @coordinates[0], "longitude" => @coordinates[1] }
      @citibike_docks = Citibikenyc.stations.values[2]

        @distances = @citibike_docks.map do |dock|
            # while dock["availableDocks"] > 0
              @distance_x = @coordinates["longitude"] - dock["longitude"]
              @distance_y = @coordinates["latitude"] - dock["latitude"]
              @distance_to_one_dock = Math.hypot( @distance_x, @distance_y )
            # end
        end   

      @final = @distances.min
      @i = @distances.index(@final)
      @winning_dock = @citibike_docks[@i]["label"]  
        
      render :index
    else
      render erb: "<%= debug Geocoder.coordinates(params[:address]) %>"
    # redirect to searches#results when search is successful. 
    end
  end

  def results
      render :results
  end

end


