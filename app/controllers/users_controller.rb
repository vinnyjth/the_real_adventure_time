class UsersController < ApplicationController
	def index
    @users = User.search(params[:search]).order("created_at asc").paginate(:per_page => 5, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user }
    end
  end

  def show
  	@user = User.find(params[:id])
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @user }
    end
  end
end
