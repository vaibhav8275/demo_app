class UsersController < ApplicationController
	def show
	  @user = current_user
	  respond_to do |format|
	    format.html
	    format.json { render json: @user }
	  end		
	end
end
