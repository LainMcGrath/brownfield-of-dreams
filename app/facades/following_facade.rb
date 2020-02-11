class FollowingFacade
  attr_reader :name,
              :url_link,
              :id

  def initialize(info)
    @name = info['login']
    @url_link = info['html_url']
    @id = info['id']
  end
end
