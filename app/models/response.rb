class Response < ActiveRecord::Base
  attr_accessible :user_id, :answer_choice_id
  validates :user_id, :answer_choice_id, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_answer_own_poll

  belongs_to(
    :respondent,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  belongs_to(
    :answer_choice,
    :class_name => "AnswerChoice",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
  )

  has_one(
    :question,
    :through => :answer_choice,
    :source => :question
  )

  def respondent_has_not_already_answered_question
    er = existing_responses
    p er
    unless er.empty? || (er.length == 1 && er.first.id == self.id)
      errors[:user_id] << "You already answered this question!"
    end
  end

  def author_cannot_answer_own_poll
    users = User.joins(:authored_polls => {:questions => :answer_choices})
               .where("answer_choices.id ", self.answer_choice_id)

    if users[0].id == self.user_id
      errors[:user_id] << "You can't answer your own poll!"
    end  
  end

  def existing_responses
    Response.find_by_sql([<<-SQL, {:user_id => self.user_id, :answer_choice_id => self.answer_choice_id}])
      SELECT
        responses.*
      FROM
        responses
      JOIN
        answer_choices
      ON
        responses.answer_choice_id = answer_choices.id
      WHERE
        responses.user_id = :user_id AND answer_choices.question_id = (
          SELECT
            answer_choices.question_id
          FROM
            answer_choices
          WHERE
            answer_choices.id = :answer_choice_id)
    SQL
  end

end
