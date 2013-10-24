class SearchesController < ApplicationController

  def new
    render :new
  end

  def create
    @coordinates = Geocoder.coordinates(params[:address])
    
    unless @coordinates.nil?

      @coordinates = { latitude: @coordinates[0], longitude: @coordinates[1] }
      all_citibike_stations = Citibikenyc.stations.values[2]

      available_stations_for_docks = all_citibike_stations.reject { |d| d["availableDocks"] == 0 }

      available_stations_for_bikes = all_citibike_stations.reject { |d| d["availableBikes"] == 0 } 

      @winning_dock_station = available_stations_for_docks.min_by do |station|
        distance_x = @coordinates[:longitude] - station["longitude"]
        distance_y = @coordinates[:latitude] - station["latitude"]
        Math.hypot( distance_x, distance_y )
      end 

      @winning_bike_station = available_stations_for_bikes.min_by do |station|
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





