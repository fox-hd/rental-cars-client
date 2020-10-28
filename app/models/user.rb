class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cpf, presence:true
  validates :cpf, uniqueness:true
  validate :cpf_valid

  private

  def cpf_valid
    if !CPF.valid?(cpf)
      errors.add(:cpf, 'não é valido')
    end
  end

end
