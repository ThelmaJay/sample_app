class UsersController < ApplicationController

#Use of before_filter so a particular method (in this case authenticate method) can be invoke before index, edit and update actions.
  before_filter :authenticate, :only => [:index, :edit, :update]

#This second before_filter is added to call the correct_user method before edit and update actions.
  before_filter :correct_user, :only => [:edit, :update]
  
#before_filter to restrict access to the destroy action to admins.
  before_filter :admin_user, :only => :destroy

#Actions

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
	@user = User.find(params[:id])
	@microposts = @user.microposts.paginate(:page => params[:page])
	@title = @user.name
  end

  def new
    if !signed_in?
	    @user = User.new
  	  @title = "Sign up"
  	else
  	  redirect_to(root_path)
  	end
  end

  def create
	if !signed_in?
	 @user = User.new(params[:user])
	 if @user.save
	  sign_in @user
		#Handle a successful save.
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
	 else
		@title = "Sign up"
		# @user.password=""
		render 'new'
	 end
	else
	  redirect_to(root_path)
	end
	end

#user edit action
	def edit
	  @title = "Edit user"
	end

#user update action
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
#The destroy action finds the user, destroys it, and then redirects to user index
  def destroy
    @user = User.find(params[:id])
    if !current_user?(@user)
      @user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    else
      redirect_to users_path
    end
  end
  
  private
  
#    def authenticate
#     deny_access unless signed_in?
#    end
    
    def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)      
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
