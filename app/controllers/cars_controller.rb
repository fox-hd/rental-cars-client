class CarsController < ApplicationController

  def index
    @cars = Car.get_cars
  end

end