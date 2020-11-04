class Car
  attr_reader :id, :license_plate, :mileage, :color

  def initialize(id:, license_plate:, mileage:, color:)
    @id = id
    @license_plate = license_plate
    @mileage = mileage  
    @color = color
  end

  def self.get_cars
    response = Faraday.get "#{Rails.configuration.apis['cars']}/cars"

    if response.status == 200
      list = JSON.parse(response.body, symbolize_names: true)
      list.map do |item|
        new(id: item[:id], license_plate: item[:license_plate],
            mileage: item[:mileage], color: item[:color])
      end
    else
      []
    end
  end

end