class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_already_answered?

  belongs_to(:user,
  class_name: 'User',
  primary_key: :id,
  foreign_key: :user_id)

  belongs_to(:answer_choice,
  class_name: 'AnswerChoice',
  primary_key: :id,
  foreign_key: :answer_choice_id)

  has_one(:question,
  through: :answer_choice,
  source: :question)

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    if self.sibling_responses.exists?(user_id: self.user.id)
      errors[:base] << "This person already answered..."
    end
  end
end
