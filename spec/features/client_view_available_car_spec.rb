require 'rails_helper'

xfeature 'client view available cars' do
  scenario 'sucessfully' do
    user = create(:user)
    login_as user, scope: :user
    json_content = File.read(Rails.root.join('spec/support/apis/get_cars.json'))
    faraday_response = double('cars', status:200, body:json_content)
    allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['cars']}/cars")
                                   .and_return(faraday_response)

    visit root_path
    click_on 'Carros disponiveis'

    expect(page).to have_content('ABC1234')
    expect(page).to have_content('Cinza')
    expect(page).to have_content('1000')
  end

  scenario 'and dont have cars' do
    user = create(:user)
    login_as user, scope: :user
    faraday_response = double('cars', status:200, body:'[]')
    allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['cars']}/cars")
                                   .and_return(faraday_response)
    visit root_path
    click_on 'Carros disponiveis'

    expect(page).to have_content('Não há carros disponiveis para locação')
  end
end