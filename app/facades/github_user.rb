class GithubUser
  def initialize(token)
    @token = token
  end
  
  def repos
    return @repos if @repos
    first_five_repos = GithubService.new.fetch_repos(@token)
    @repos = first_five_repos.map do |repo_info|
      RepoFacade.new(repo_info)
    end
  end

  def followers
    return @followers if @followers
    followers = GithubService.new.get_followers(@token)

    @followers = followers.map do |follower_info|
      FollowerFacade.new(follower_info)
    end
  end

  def followings
    return @followings if @followings
    followings = GithubService.new.get_followings(@token)

    @followings = followings.map do |following_info|
      FollowingFacade.new(following_info)
    end
  end
end