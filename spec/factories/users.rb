FactoryBot.define do
  factory :user do
    name {'Ipsum Lorem'}
    cpf {CPF.generate}
    sequence(:email) {|i| "test#{i}@test.com.br"}
    password {'123456'}
  end
end
