class SearchesController < ApplicationController

  def index
    @coordinates = Geocoder.coordinates(params[:address])

    unless @coordinates.nil?
      
      @coordinates = { "latitude" => @coordinates[0], "longitude" => @coordinates[1] }
      @citibike_docks = Citibikenyc.branches.values[2]

      @distances = @citibike_docks.map do |dock|
      @distance_x = @coordinates["longitude"] - dock["longitude"]
      @distance_y = @coordinates["latitude"] - dock["latitude"]

      @distance_to_one_dock = Math.hypot( @distance_x, @distance_y )
      [dock["label"], @distance_to_one_dock]
      end

      binding.pry

      #@distances.min
      #@final_glorious_answer = Geocoder.address(@closest_dock)
 
      render :index
    else
      render erb: "<%= debug Geocoder.coordinates(params[:address]) %>"
    end

  end

end