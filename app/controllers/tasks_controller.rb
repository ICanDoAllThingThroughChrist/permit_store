class TasksController < ApplicationController
    include SessionsHelper
    # before_action :admin, only => [:new, :create]
    # load_and_authorize_resource :nested => :Permit
    def index
        @tasks = Task.all
    end
    def new
            @user= current_user
            #@permits= @user.permits.pluck(:title, :id)
            @permits= Permit.pluck(:title, :id)
            #@Permitex= Permit.group(:title).pluck(:title, :id)
            #@permits= Permit.group(:title).where(:shipped == "false")
            @task = Task.new
        #https://stackoverflow.com/questions/48285481/how-do-you-use-a-single-select-dropdown-with-rails-has-many-through-association
    end
    def create
        #binding.pry
        if current_user.role_id == admin
            binding.pry
            @task = Task.new(task_params)
            binding.pry
            if @task.save 
            flash[:notice] = "task has been created."
            redirect_to @task 
            else
            flash[:alert] = "task has not been created."
            render "new"
            end
        else 
            flash[:notice] = "You are not authorized to perform this action" 
        end    
    end
    def show
        @task = Task.find(params[:id])
    end
    def edit
        @user= current_user
        @permits= @user.permits.pluck(:title, :id)
        @task = Task.find(params[:id])
    end
    def update 
        #binding.pry
        @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:notice] = "task has been updated."
            redirect_to @task
          else
            flash.now[:alert] = "task has not been updated."
            render "edit"
        end

    end 
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        flash[:notice] = "task has been deleted."
        redirect_to tasks_path
    end

private
    def task_params
        params.require(:task).permit(
            :title,:description,:image,:size,
            :URL,:image_cache, :remove_image,
            permit_ids:[])
    end
#As an administrator I want to be able to 
# add a new task to a Permit"=>Admin::PermittasksController#New;
#Create" (title, description, image, size, URL to buy 
# more from amazon or other partners)
end
