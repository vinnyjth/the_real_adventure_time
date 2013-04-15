class UsersController < ApplicationController
	def index
    @users = User.search(params[:search]).order("created_at asc").page(params[:page])

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


  def add_user_to_group
    @group = Group.find(params[:group])
    @user = Group.find(params[:id])
    @group.users << @user
  end
end
