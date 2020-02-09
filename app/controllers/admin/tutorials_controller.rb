class Admin::TutorialsController < Admin::BaseController
  def new
  end

  def create
    tutorial = Tutorial.create(tutorial_params)
    if tutorial.save
      redirect_to tutorial_path(tutorial)
      flash[:notice] = 'Tutorial successfully created'
    else
      flash[:notice] = tutorial.errors.full_messages
      render :new
    end
  end

  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy
    redirect_to admin_dashboard_path
    flash[:notice] = 'Deleted tutorial'
  end
  private

  def tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
