class MicropostsController < ApplicationController
	before_filter :authorized_user, :only => :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if  @micropost.save
	  	    redirect_to root_path, :flash => { :success => "Micropost created!" } 
		else
			@feed_items = current_user.feed.paginate(:page => params[:page])
	  		render 'pages/home'
		end
	end

	def destroy
		@micropost.destroy
    	redirect_to root_path, :flash => { :success => "Micropost deleted!" }
	end

	private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def authorized_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end

end
