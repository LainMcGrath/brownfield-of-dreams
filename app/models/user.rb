class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  validates :email, uniqueness: true, presence: true
  # validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.update_user(params, current_user)
    current_user.uid = params[:uid]
    current_user.token = params[:credentials][:token]
    current_user.login = params[:extra][:raw_info][:login]
    current_user.save!
  end

  def self.relationship(user_id, follower_id)
    Follow.find_by(follower_id: follower_id, followee_id: user_id)
  end

  def self.uid_in_database(follower_id)
    User.find_by(uid: follower_id)
  end
end
