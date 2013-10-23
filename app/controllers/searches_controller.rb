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

        # @distances = @citibike_docks.map do |dock|       
        #   unless dock["availableDocks"] == 0
        #       @distance_x = @coordinates["longitude"] - dock["longitude"]
        #       @distance_y = @coordinates["latitude"] - dock["latitude"]
        #       @distance_to_one_dock = Math.hypot( @distance_x, @distance_y )
        #   end
        # end

        @distances = {}

        @citibike_docks. each do |dock|
          unless dock["availableDocks"] == 0
              @distance_x = @coordinates["longitude"] - dock["longitude"]
              @distance_y = @coordinates["latitude"] - dock["latitude"]
              @distances[dock["label"]] = Math.hypot( @distance_x, @distance_y )
          end
        end 

      # define hash where key == station name & value == it's distance

# associate the label with the distance that we generated. 

      # delete key value pairs that have distance == nil
      # @distances.delete_if { |station, distance| distance == nil }

      # sort by distances in ascending order
      @sorted_distances = @distances.sort_by { |station, distance| distance }
      # retrieve array for shorted distance with
      # first element == station name
      # second element == it's distance
      @closest_station = @sorted_distances.first #=> [station_name, distance]

      # @final = @distances.min
      # @closest_station[1] #distances

      # @i = @distances.index(@final)

      # @winning_dock = @citibike_docks[@i]["label"]  
      @winning_dock = @closest_station[0] #call me

      # @citibike_docks[1]["availableDocks"] == 37

      closest = @citibike_docks.select { |dock| dock["label"] == @closest_station[0] }

      @winning_dock_available_docks = closest.first["availableDocks"] #call me
        
      render :index
    else
      render erb: "<%= debug Geocoder.coordinates(params[:address]) %>"
    # redirect to searches#results when search is successful. 
    end
  end

private

 def favorite?
    favorites[user_id].present? == false
  end

end


    # <li><h3><%="#{@winning_dock} has #{@citibike_docks[@i]["availableDocks"] } docks available. Huzzah!!" %></h3></li>

