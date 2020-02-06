class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  #
  # validates :email, uniqueness: true, presence: true
  # validates_presence_of :password
  # validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.github_login(session_params)
    client_id = '13bb7d4ef6b3c23576d2'
    client_secret = 'd1ba88fb71c5a1f99156628b3aa15a68741fa9e0'
    code = session_params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

    pairs = response.body.split("&")
    response_hash = {}
    pairs.each do |pair|
      key, value = pair.split("=")
      response_hash[key] = value
    end

    token = response_hash["access_token"]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

    auth = JSON.parse(oauth_response.body)


    user = User.find_by(uid: auth['id'])
    User.update(user.id,
     :uid => auth["id"],
     :token => token,
     :login => auth['login'])
# require "pry"; binding.pry
    # user = User.find_or_create_by(uid: auth['id'])
    # user.login = auth['login']
    # user.uid = auth['id']
    # user.token = token
    # user.save!
    require "pry"; binding.pry


    user
     # session[:user_id] = user.id
    # github: OAuth2 token (sent in a header)
    # curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com
    # Note: GitHub recommends sending OAuth tokens using the Authorization header.
  end
end
