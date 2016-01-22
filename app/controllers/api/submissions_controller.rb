class API::SubmissionsController < API::BaseController
  before_action :set_submission, only: :show

  def show
    render json: @submission
  end

  def create
    @submission = Submission.new submission_params
    @submission.game_session = current_session

    if @submission.save
      SubmissionQueueJob.perform_later(@submission.id)
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
    params.require(:submission).permit :content, :level_id
  end
end
