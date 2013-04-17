class PathsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_ownership, :only => [:destroy]

	def index
		@paths = current_user.paths.all
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
        	format.html { redirect_to Page.find(@path.page_to_id), notice: 'Path was successfully created.' }
        	format.json { render json: @path, status: :created, location: @path }
        end
    else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @path.errors, status: :unprocessable_entity }
      end
	  end
  end

  def destroy
    @path = Path.find(params[:id])
    @path.destroy
    respond_to do |format|
      format.html { redirect_to paths_url }
      format.json { head :no_content }
    end
  end

  private
  def check_ownership
    @path = Path.find(params[:id])
    unless current_user.paths.include?(@path) || current_user.admin?
      flash[:error] = "You do not belong to the group that owns this path. Sorry bud :("
        redirect_to paths
      end
    end
end
