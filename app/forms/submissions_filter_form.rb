class SubmissionsFilterForm
  include ActiveAttr::Model

  attr_accessor :submissions

  attribute :finished_game, type: Integer
  attribute :level_id, type: Integer
  attribute :game_session_id, type: Integer

  def initialize(submissions)
    super()
    self.submissions = submissions
  end

  def submit(params)
    self.attributes = params
    return submissions.none unless valid?

    values   = []
    criteria = []

    attributes.each do |name, value|
      next if value.blank? || value == 0

      criterion = if name == "finished_game"
                    value = GameSession.finished.pluck(:id)
                    "submissions.game_session_id IN (?)"
                  else
                    "submissions.#{name} = ?"
                  end

      criteria << criterion
      values   << value
    end

    submissions.where(criteria.join(" AND "), *values)
  end
end
