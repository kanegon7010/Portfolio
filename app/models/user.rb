# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string(255)
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

  has_one :cv, dependent: :delete
  has_many :following_relationships,foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships,foreign_key: "following_id",class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :microposts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  mount_uploader :avatar, AvatarUploader

  VALID_PASSWORD_REGEX =/\A[a-zA-Z0-9_.-]+\z/
  validates :username, presence: true
  validates :service_id, 
    presence: true,
    uniqueness: true,
    length: { minimum: 6 },
    format: { 
      with: VALID_PASSWORD_REGEX
    }
  validates :password, on: :create, format: { with: VALID_PASSWORD_REGEX }
  validates :password, on: :update, allow_blank: true, format: { with: VALID_PASSWORD_REGEX }
  
  def following?(other_user)
    self.followings.include?(other_user)
  end

  def feed
    following_ids_subselect = "SELECT following_id FROM relationships 
                      WHERE follower_id = :user_id"
    Micropost.eager_load(:user, :replied_relationships, :replied).where("microposts.user_id IN (#{following_ids_subselect}) OR microposts.user_id = :user_id",
                  user_id: id)
  end

  #ユーザーをフォローする
  def follow(other_user)
    unless self == other_user.id
      self.following_relationships.find_or_create_by(following_id: other_user.id)
    end
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end

  #フォロー通知のデータを作成する
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.service_id = 'guestuser'
      user.username = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

end
