require 'rails_helper'

feature 'client view all subsidiaries' do
  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    json_content = File.read(Rails.root.join('spec/support/apis/get_subsidiaries.json'))
    faraday_response = double('subs', status:200, body:json_content)
    allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                   .and_return(faraday_response)

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Lorem Ipsun I')
    expect(page).to have_content('50.668.157/0001-68')
    expect(page).to have_content('Av. paulista, 1000')
  end

  scenario 'and dont ave subsidiaries' do
    user = create(:user)
    login_as user, scope: :user
    faraday_response = double('subs', status:200, body:'[]')
    allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                   .and_return(faraday_response)

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content ('Não há filiais cadastradas')

  end


end