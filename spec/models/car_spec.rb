require 'rails_helper'

describe Car, type: :model do
  context 'get all cars available' do
    it 'fetch all cars from API' do
      json_content = File.read(Rails.root.join('spec/support/apis/get_cars.json'))
      faraday_response = double('cars', status:200, body:json_content)

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['cars']}/cars")
                                     .and_return(faraday_response)
                                     
      result = Car.get_cars

      expect(result.length).to eq 2
      expect(result.first.license_plate).to eq 'ABC1234'
      expect(result.second.license_plate).to eq 'DEF1234'
    end

    it 'fetch no cars from API' do
      faraday_response = double('cars', status:200, body:'[]')

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['cars']}/cars")
                                     .and_return(faraday_response)

      result = Car.get_cars

      expect(result.length).to eq 0
    end

    it 'error API' do
      faraday_response = double('cars', status: 500)

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['cars']}/cars")
                                     .and_return(faraday_response)

      result = Car.get_cars
      
      expect(result.length).to eq 0
    end
  end
end