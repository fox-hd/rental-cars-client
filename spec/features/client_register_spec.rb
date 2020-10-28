require 'rails_helper'

feature 'client login on system' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastro'
    fill_in 'Nome', with: 'Lorem Ipsum'
    fill_in 'CPF', with: '082.923.869-71'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo')
  end

  scenario 'and must fill all fields' do
    visit root_path
    click_on 'Cadastro'
    click_on 'Cadastrar'

    expect(page).to have_content('não pode ficar em branco', count:4)
  end
  
  scenario 'and cpf must be valid' do
    visit root_path
    click_on 'Cadastro'
    fill_in 'Nome', with: 'Lorem Ipsum'
    fill_in 'CPF', with: '082.923.869-00'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(page).to have_content('não é valido')
  end

  scenario 'and cpf alredy exists' do
    user = create(:user)
    
    visit root_path
    click_on 'Cadastro'
    fill_in 'Nome', with: user.name
    fill_in 'CPF', with: user.cpf
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    fill_in 'Confirme sua senha', with: user.password
    click_on 'Cadastrar'

    expect(page).to have_content('já está em uso')
  end
end