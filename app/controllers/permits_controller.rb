class PermitsController < ApplicationController
    # include Currentpermit
    include SessionsHelper
    before_action :admin, :only => [:create, :update]
   
    def index
        @user= current_user 
        # #binding.pry
        @user_permits= []
        #binding.pry
        @user.orders.each do |order|
        order.permits.each do |permit|
            @user_permits << permit
          end 
        end
        @user_permits
        @user_orders = Permit.order(:id).paginate(page: params[:page], per_page: 2)
        #@subscriber_users_permits = permit.order(:id).paginate(page: params[:page], per_page: 1)
    end

    def show
        #/permits/1/tasks should show all of the tasks 
        #in permit #1 to anyone who wants to see it 
        #means no current_user
        @permit = Permit.find(params[:id])
        ##binding.pry
    end

    def new 
            @user = current_user
            #@permit = @user.permits.build
            #@permit = set_permit
            #@user.permits.build
            @permit = @user.permits.build
            #authorize! :new, @permit
             3.times do
                @permit.tasks.build
            end
            #@task = task.all
            @task = Task.group(:title)
    end
    def create 
        #binding.pry
        #permits/1/tasks/new should allow an 
        #administrator to add a new task to a permit.
        #=>before_action :admin, only => [:create]
        @task = Task.all
        ##binding.pry
        #because once again load_resource takes care of this for us.
        @permit = Permit.new(permit_params) 
        @user = current_user
        @permit.user_id= params[:permit][:user_id]
            if current_user.orders.last == nil
                flash[:notice] = "please purchase an order to buy a permit"
            else
                @order = current_user.orders.last
                @user.orders.push @order 
                @order2= @user.orders.last 
                @order2.permits.push @permit
            end
        #e.g. admin only! subscriber only needs to know where "see nav link"
        if admin
            if @permit.save 
                ##binding.pry
                #@user = current_user
                ##binding.pry
                @user.subscriber= true #after_action assigns user to be a subscribe
                flash[:notice] = "permit has been created."
                redirect_to @permit 
            else
                flash[:alert] = "permit has not been created."
                render "new"
            end
        else #e.g. is a visitor only!
            flash[:alert] = "please sign up for site And log in as admin to create a permit"
            redirect_to login_url
        end
    end
    def edit
       @permit = permit.find(params[:id])
        # authorize! :edit, @permit
    end
    def update 
        if admin
            @permit = permit.find(params[:id])
            if @permit.update(permit_params)
                flash[:notice] = "permit has been updated."
                redirect_to @permit
            else
                flash.now[:alert] = "permit has not been updated."
                render "edit"
            end
        else #e.g. is a visitor only!
            flash[:alert] = "please sign up for site And log in as admin to create a permit"
            redirect_to login_url
        end

    end 
    def destroy
        @permit = Permit.find(params[:id])
        @permit.destroy
        flash[:notice] = "permit has been deleted."
        redirect_to root# to be determined
    end
    #As a subscriber I want to see what permits i received
    def permits_received
        if current_user
            @user= current_user 
            @user.permits.each do |permit|
                if permit.received
                    "#{permit.title}"
                end 
            end 
        end 
    end 

private
    def invalid_permit
    logger.error "Attempt to access invalid permit #{params[:id]}"
    redirect_to permits_ptah, flash[:notice]='invalid permit'
    end
    def load_permits
        @permits = permit.accessible_by(current_ability).order('created_at DESC')
      end
    def permit_params
        #- As an administrator I want 
        #to be able to create a new permit 
        #(site level, 
        #month and year to uniquely identify it 
        #and a title for the theme e.g. 
        #“cat coolers for summer”)
        params.require(:permit).permit(
        :shipped, :order_id,
        :user_id, :site_level,:month,
        :year,:title, task_ids:[],
        tasks_attributes: [:title])
    end
end
