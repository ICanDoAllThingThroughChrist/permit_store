class SitesController < ApplicationController 
        def index
            @sites = Site.all
        end
        def show 
            @site = Site.find(params[:id])
        end
        def new
            #As a visitor I want to be able to 
            #purchase a site
            #just ask for first name, last name and email 
            @site = Site.new 
        end
        def create
            binding.pry
            if @site.save 
              flash[:notice] = "site has been created."
              redirect_to @site 
            else
              flash[:alert] = "site has not been created."
              render "new"
            end 
        end

        def edit
            @site = Site.find(params[:id])
        end
        def update 
            binding.pry
            @site = Site.find(params[:id])
            if @site.update(site_params)
                flash[:notice] = "site has been updated."
                redirect_to @site
            else
                flash.now[:alert] = "site has not been updated."
                render "edit"
            end
        end 
        def delete
        end

        private
        def site_params
            params.require(:site).permit(:level,:description, :rate, :id)
        end

end

