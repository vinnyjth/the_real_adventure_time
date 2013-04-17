class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:add_user_to_group]
  before_filter :check_ownership, :only => [:add_user_to_group]
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
    @user = User.find(params[:user])
    @group = Group.find(params[:group])
    if !@user.groups.include? @group
      @group.users << @user
      redirect_to :back
    else
      redirect_to :back, :notice => "user already belongs to this group"
    end
  end

  private
  def check_ownership
    @group = Group.find(params[:group])
    unless current_user.groups.include?(@group) || current_user.admin?
      flash[:error] = "You do not belong to that group"
      redirect_to groups
    end
  end

end
