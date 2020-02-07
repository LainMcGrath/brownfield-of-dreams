class GithubUser

  def initialize(token)
    @token = token
  end
  
  def repos
    return @repos if @repos
    json = GithubService.new.fetch_repos(@token)

    @repos = json[:results].map do |repo_info|
      RepoFacade.new(repo_info)
    end
  end

  def followers
  end

  def following
  end
end