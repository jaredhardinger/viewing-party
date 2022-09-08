class SessionsController < ApplicationController
   
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            # binding.pry
            redirect_to '/'
            flash[:success] = "Welcome, #{user.email}!"
        else
            flash[:error] = "Sorry, your credentials are bad."
            render :new
        end
    end

    def destroy
        session.destroy
        redirect_to root_path
    end
end