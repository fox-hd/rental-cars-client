class Subsidiary
  attr_reader :id, :name, :cnpj, :address

  def initialize(id:, name:, cnpj:, address:)
    @id=id
    @name=name
    @cnpj=cnpj
    @address=address
  end

  def self.get_subsidiaries
    response = Faraday.get "#{Rails.configuration.apis['subsidiaries']}/subsidiaries"

    if response.status == 200
      list = JSON.parse(response.body, symbolize_names:true)
      list.map do |item|
        new(id: item[:id], name: item[:name], cnpj: item[:cnpj], address: item[:address])
      end
    else
      []
    end
  end


end