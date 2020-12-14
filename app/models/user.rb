# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  username               :string(255)      default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  service_id             :string(255)      default(""), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_service_id            (service_id) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX =/\A[a-z0-9]+\z/
  validates :service_id, 
    presence: true,
    uniqueness: true,
    length: { minimum: 6 },
    format: { 
      with: VALID_PASSWORD_REGEX
    }
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.service_id = 'guestuser'
      user.username = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

end
