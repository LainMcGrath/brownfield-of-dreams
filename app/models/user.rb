class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  # validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.github_login(session_params, user)
    # client_id = '13bb7d4ef6b3c23576d2'
    # client_secret = 'd1ba88fb71c5a1f99156628b3aa15a68741fa9e0'
    code = session_params[:code]

    GithubService.new.login(code)


    # response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    # token_params = response.body.split("&").first.split('=')
    # token = { token_params[0] => token_params[1] }
    # oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token["access_token"]}")

    # auth = JSON.parse(oauth_response.body)

    user.login = auth['login']
    user.uid = auth['id']
    user.token = token["access_token"]
    user.save
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
