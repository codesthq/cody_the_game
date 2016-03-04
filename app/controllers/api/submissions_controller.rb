class API::SubmissionsController < API::BaseController
  before_action :set_submission, only: :show
  before_action :authorize_level!, only: :create

  def show
    render json: @submission
  end

  def create
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

  def authorize_level!
    unless level_authorizer.authorized? level_number
      head status: :unauthorized
    end
  end

  def level_authorizer
    @level_authorizer ||= LevelAuthorizer.new current_session
  end

  def level_number
    submission_params[:level_id]
  end

  def enqueue_submission_verification(submission)
    SubmissionVerifierJob.perform_later submission.id
  end

  def set_submission
    @submission = Submission.find params[:id]
  end

  def submission_params
    params.require(:submission).permit :content, :level_id
  end
end
