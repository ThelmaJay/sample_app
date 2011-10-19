class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      #Adding an (empty) feed_items instance var to the create action.
      #Therefore correcting the problem : On failed micropost submission, the home page expects an feed_items instance var, so failed submissions would break.
      #This way we suppress the feed entirely by assigning it an empty array.
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    redirect_back_or root_path 
  end
  
  private
    def authorized_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end
end