class RepoFacade
  attr_reader :name,
              :url

  def initialize(info)
    @name = info['name']
    @url = info['svn_url']
  end
end
