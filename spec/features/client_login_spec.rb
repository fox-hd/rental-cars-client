require 'rails_helper'

feature 'client login system' do
  scenario 'sucessfully' do
    user = create(:user)
    
    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    
    expect(page).to have_content('Bem vindo')
  end
end