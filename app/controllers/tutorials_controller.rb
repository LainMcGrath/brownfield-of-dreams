class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom == false || current_user
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      render file: '/public/404'
    end
  end

  def update
    tutorial = Tutorial.find(params[:id])
    tutorial.tags.create(name: params[:tutorial][:tag_list])
  end

  def index
    @tutorials = Tutorial.all
  end
end
