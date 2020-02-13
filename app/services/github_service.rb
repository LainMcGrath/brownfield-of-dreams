class GithubService
  def fetch_repos(token)
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{token}")
    JSON.parse(response.body)[0..4]
  end

  def get_followers(token)
    response = Faraday.get("https://api.github.com/user/followers?access_token=#{token}")
    JSON.parse(response.body)
  end

  def get_followings(token)
    response = Faraday.get("https://api.github.com/user/following?access_token=#{token}")
    JSON.parse(response.body)
  end

  def get_email_from_handle(handle, token)
    response = Faraday.get("https://api.github.com/users/#{handle}?access_token=#{token}")
    if response['status'] != '404 Not Found'
      [JSON.parse(response.body)['email'], JSON.parse(response.body)['login']]
    else
      'error'
    end
  end
end
