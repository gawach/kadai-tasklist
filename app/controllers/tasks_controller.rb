class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def show
  end

  def new
  end
  
  def create
  end
  
  def edit
  end

  def update
  end
  
  def destroy
  end
  
  
  private
  
  def message_params
      params.require(:message).permit(:content)
  end
end
