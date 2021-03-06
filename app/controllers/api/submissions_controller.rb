class API::SubmissionsController < API::BaseController
  before_action :set_submission, only: :show

  def show
    authorize_submission! @submission

    render json: @submission
  end

  def create
    authorize_level! level_number

    @submission = Submission.new submission_params
    @submission.game_session = current_session

    if @submission.save
      enqueue_submission_verification @submission
      render json: @submission
    else
      render json: { errors: @submission.errors }, status: :unprocessable_entity
    end
  end

  private

  def enqueue_submission_verification(submission)
    SubmissionVerifierJob.perform_later submission.id
  end

  def set_submission
    @submission = Submission.find params[:id]
  end

  def level_number
    submission_params[:level_id]
  end

  def submission_params
    params.require(:submission).permit :content, :level_id
  end
end
