class Therapist < ApplicationRecord
  rolify
  has_many :patients, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  validates :unique_id, presence: true, length: { is: 8 }, uniqueness: true
  validates :name, presence: true

  def will_save_change_to_email?
    false
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
