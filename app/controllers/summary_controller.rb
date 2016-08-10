class SummaryController < ApplicationController
  def show
  end

  def update
    current_session.email = params[:email]
    if current_session.save
      redirect_to root_path
    else
      @message = "Your email is not valid"
      render :show
    end
  end
end
