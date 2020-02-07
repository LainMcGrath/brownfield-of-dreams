class GithubService
  def fetch_repos(token)
    Faraday.get("https://api.github.com/user/repos?access_token=#{token}")
  end
end
