class Statistics::SubmissionsController < Statistics::BaseController
  before_action :set_submission, only: :show

  def index
    submissions = Submission.correct.order("created_at DESC, id DESC, level_id DESC")

    @filter_form = SubmissionsFilterForm.new(submissions)

    @sessions = GameSession.finished
    @levels   = Level.all

    if params[:filter]
      submissions = @filter_form.submit(params[:filter])
    end

    @submissions = submissions
  end

  def show
  end

  private

  def set_submission
    @submission = Submission.find params[:id]
  end
end