class SubmissionsController < API::V1::BaseController
  before_action :set_submission, only: :show

  def show
    render json: @submission
  end

  def create
    @submission = Submission.new submission_params

    if @submission.save
      render json: @submission
    else
      render json: { errors: @submission.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_submission
    @submission = Submission.find params[:id]
  end

  def submission_params
    params.require(:submission).permit :content
  end
end