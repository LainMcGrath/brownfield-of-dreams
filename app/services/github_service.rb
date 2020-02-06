class GithubService
  def login(code)
    client_id = '13bb7d4ef6b3c23576d2'
    client_secret = 'd1ba88fb71c5a1f99156628b3aa15a68741fa9e0'

    response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    token_params = response.body.split("&").first.split('=')
    token = { token_params[0] => token_params[1] }
    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token["access_token"]}")

    auth = JSON.parse(oauth_response.body)

    # user.login = auth['login']
    # user.uid = auth['id']
    # user.token = token["access_token"]
    # user.save
  end
end