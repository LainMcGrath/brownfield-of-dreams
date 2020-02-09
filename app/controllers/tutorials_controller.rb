class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  def update
    tutorial = Tutorial.find(params[:id])
    tutorial.tags.create(name: params[:tutorial][:tag_list])
  end
end
