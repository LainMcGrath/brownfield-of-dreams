class RepoFacade
  attr_reader :name, :url
  def initialize(info)
    require 'pry'; binding.pry
    @name = info['name']
    @url = info['svn_url']
  end
end