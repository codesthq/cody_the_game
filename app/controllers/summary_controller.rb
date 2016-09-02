class SummaryController < ApplicationController
  def show
    if summary_authorizer.authorized?
      render :show
    else
      redirect_to root_path
    end
  end

  def update
    current_session.email = params[:email]
    if current_session.save
      @show_success = true
      render :show
    else
      @message = "Your email is not valid"
      render :show
    end
  end

  private

  def summary_authorizer
    @summary_authorizer = SummaryAuthorizer.new(current_session)
  end

  def authorized?
    summary_authorizer
  end
end
