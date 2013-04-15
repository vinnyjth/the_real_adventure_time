class PathsController < ApplicationController
  before_filter :authenticate_user!

	def index
		@paths = Path.all
	end
	
	def new 
		@path = Path.new
		if(params.has_key?(:root_id)) 
      		@root = Page.find(params[:root_id])
      respond_to do |format|
            format.html # new.html.erb
            format.json { render :json => @page }
          end
        else 
          redirect_to :back, notice: "You can't create a path without a root page"
        end
    end
	
	def create
		@path = Path.new(params[:path])
		if @path.save
      respond_to do |format|
        	format.html { redirect_to @path, notice: 'Path was successfully created.' }
        	format.json { render json: @path, status: :created, location: @path }
        end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @path.errors, status: :unprocessable_entity }
      end
	  end
  end
end
