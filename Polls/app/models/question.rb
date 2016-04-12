class Question < ActiveRecord::Base
  validates :poll_id, presence: true

  belongs_to(:poll,
  class_name: 'Poll',
  primary_key: :id,
  foreign_key: :poll_id)

  has_many(:answer_choices,
  class_name: 'AnswerChoice',
  primary_key: :id,
  foreign_key: :question_id)

  has_many(:responses,
  through: :answer_choices,
  source: :responses)

  #N+1 query
  # def results
  #   response_count = Hash.new(0)
  #
  #   self.responses.each do |response|
  #     response_id = response.answer_choice_id
  #     text = AnswerChoice.find(response_id).text
  #     response_count[text] += 1
  #   end
  #   response_count
  # end

  #better results
  # def results
  #   response_count = Hash.new(0)
  #
  #   self.answer_choices.includes(:responses).each do |answer_choice|
  #
  #     response_count[answer_choice.text] = answer_choice.responses.length
  #   end
  #
  #   response_count
  # end

  def results
    results_count = Hash.new(0)

    joins_sql = <<-SQL
      LEFT OUTER JOIN
        responses
      ON
        responses.answer_choice_id = answer_choices.id
    SQL

    responses = self.answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS answer_count")
      .joins(joins_sql)
      .group("answer_choices.id")

    responses.each do |response|
      results_count[response.text] = response.answer_count
    end
    results_count
  end

  # select
  #   answer_choices.*, COUNT(responses.id) AS answer_count
  # from
  #   questions
  # join
  #   answer_choices ON questions.id = answer_choices.question_id
  # left outer join
  #   responses on responses.answer_choice_id = answer_choices.id
  # where
  #   questions.id = self.id
  # group by
  #   answer_choices.id
  # order by
  #   answer_choices.question_id

end
