class OrdersController < ApplicationController
        
        def index
            if current_user
            #binding.pry
            @orders = Order.find_by_sql ["SELECT id FROM Orders WHERE user_id = ?", current_user]
            end
            @orders_ordered = Order.order(:id).paginate(page: params[:page], per_page: 4)
            #binding.pry
            #@subscriber_users_permits = Box.order(:id).paginate(page: params[:page], per_page: 1)
        end

        def new
            @user = current_user
            @order = Order.new
            #binding.pry
        end

        def create
            #binding.pry
            if current_user 
                ##binding.pry
                # @user = current_user
                # @site= site.find(params[:order][:site_id])
                # @user.sites.push @site
                #binding.pry
                @order = Order.new(order_params)
                #binding.pry
                @order.user_id= current_user.id        
                #@user.sites.orders.push @order
                ##binding.pry
                if @order.save
                    #binding.pry
                    flash[:notice]= "new site order saved"
                else  
                    flash[:notice]= "site order not saved"
                end 
                #binding.pry
                render "show"
            else 
                flash[:alert] = "please sign up and log in to purchase site order and to add permits"
                redirect_to login_url
            end 
        end

    
        def show
            #binding.pry
            @order = Order.find(params[:id])
        end

        def edit
            @order = Order.find(params[:id])
        end

        def update 
            #binding.pry
            if current_user 
                @order = Order.find(params[:id])
                if @order.update(order_params)
                    flash[:notice] = "site has been updated."
                    redirect_to @site
                else
                    flash.now[:alert] = "site has not been updated."
                    render "edit"
                end
            end
        end 

        def delete
            @order = Order.find(params[:id])
            @order.destroy 
            flash[:notice] = "order has been deleted"
            redirect_to orders_path
        end

        def toggle_cancellation
            @order = Order.find(params[:id])
            if @order.cancellation == nil 
                #binding.pry
              @order.cancellation= true
              @order.save
              flash[:notice] = "Your site order has been marked cancelled"
              redirect_to permits_path
            else
              @order.cancellation= false
              @order.save
              redirect_to permits_path
            end
        end

        private
        def order_params
            params.require(:order).permit(:first_name,
            :last_name, :email, :id,
            :site_id, :site,
            :user_id, :task_ids)
        end
end
