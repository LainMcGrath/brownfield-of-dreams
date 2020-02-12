class FollowerFacade
  attr_reader :name,
              :url_link,
              :id

  def initialize(info)
    require 'pry'; binding.pry
    @name = info['login']
    @url_link = info['html_url']
    @id = info['id']
  end
end
