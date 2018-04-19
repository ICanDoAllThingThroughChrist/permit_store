class PermitTasksController < ApplicationController
    before_action :set_permit, only: [:create]
    before_action :set_permit_task, only: [:show, :edit, :update, :destroy]
      # GET /line_tasks/new
  def new
    @line_task = PermitTask.new
  end
    
  def create
        @permit = set_permit
        @order = set_order#i think
        @permit.build_order(@order)#i think
        task = Task.find(params[:task_id])
        @permit_task = @permit.add_task(task)
        if @permit_task.save
          redirect_to @permit_task.permit, {notice: 'task added to permit!'}
        else
          redirect_to tasks_path, {notice: 'Unable to add task'}
        end
  end

    # GET /line_tasks/1/edit
  def edit
  end

  def permit_tasks_params 
      params.require(:permit_task).permit(:task_id)
  end
end
