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
end
