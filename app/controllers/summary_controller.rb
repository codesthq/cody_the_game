class SummaryController < ApplicationController
  def show
  end

  def update
    current_session.email = params[:email]
    if current_session.save
      @message = "Thank you for your email."
    else
      @message = "Your email is not valid"
    end

    render :show
  end
end
