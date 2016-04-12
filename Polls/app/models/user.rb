class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(:authored_polls,
  class_name: 'Poll',
  primary_key: :id,
  foreign_key: :author_id)

  has_many(:responses,
  class_name: 'Response',
  primary_key: :id,
  foreign_key: :user_id)

  def completed_polls
    result = <<-SQL
    SELECT
    polls.id
    FROM
    polls
    INNER JOIN
    questions ON questions.poll_id = polls.id
    INNER JOIN
    answer_choices
    ON
    answer_choices.question_id = questions.id
    LEFT OUTER JOIN
    (SELECT
      *
      FROM
      responses
      WHERE
      responses.user_id = ?) AS responses_user
      ON
      responses_user.answer_choice_id = answer_choices.id

      GROUP BY
      polls.id
      HAVING
      COUNT(DISTINCT(questions.id)) = COUNT(DISTINCT(responses_user.id))

      SQL

      Poll.find_by_sql([result, self.id])
    end

    def uncompleted_polls

      result = <<-SQL
      SELECT
      polls.id
      FROM
      polls
      INNER JOIN
      questions ON questions.poll_id = polls.id
      INNER JOIN
      answer_choices
      ON
      answer_choices.question_id = questions.id
      LEFT OUTER JOIN
      (SELECT
        *
        FROM
        responses
        WHERE
        responses.user_id = ?) AS responses_user
        ON
        responses_user.answer_choice_id = answer_choices.id

        GROUP BY
        polls.id
        HAVING
        COUNT(DISTINCT(questions.id)) != COUNT(DISTINCT(responses_user.id))

        SQL

        Poll.find_by_sql([result, self.id])

    end

end
