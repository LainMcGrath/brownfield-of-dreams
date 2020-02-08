class FollowerFacade
  attr_reader :name, 
              :url_link

  def initialize(info)
    @name = info['login']
    @url_link = info['html_url']
  end
end