class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

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

  def self.fetch_repos(user_id)
    user = User.find(user_id)
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{user.token}")
    repo_response = JSON.parse(response.body)[0..4]
    repo_response.map do |repo_info|
      RepoFacade.new(repo_info)
    end
  end
end
