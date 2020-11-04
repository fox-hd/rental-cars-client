require 'rails_helper'

describe Subsidiary, type: :model do
  context 'get all subsidiaries' do
    it 'fetch all subsidiaries from API' do
      json_content = File.read(Rails.root.join('spec/support/apis/get_subsidiaries.json'))
      faraday_response = double('subs', status:200, body: json_content)
      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.get_subsidiaries

      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Lorem Ipsun I'
      expect(result.second.name).to eq 'Lorem Ipsun II'
    end

    it 'fetch no subsidiaries from API' do
      faraday_response = double('subs', status:200, body:'[]')
      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.get_subsidiaries

      expect(result.length).to eq 0
    end

    it 'error fom API' do
      faraday_response = double('subs', status:500)
      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.get_subsidiaries

      expect(result.length).to eq 0
    end
  end
end