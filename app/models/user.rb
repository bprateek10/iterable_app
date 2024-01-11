class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_user_in_iterable

  private

  def create_user_in_iterable
    IterableService.create_user(id, email, "#{first_name} #{last_name}")
  end
end
