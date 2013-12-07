class Question < ActiveRecord::Base
  attr_accessible :text, :poll_id
  validates :text, :poll_id, :presence => true

  belongs_to(
    :poll,
    :class_name => "Poll",
    :foreign_key => :poll_id,
    :primary_key => :id
  )

  has_many(
    :answer_choices,
    :class_name => "AnswerChoice",
    :foreign_key => :question_id,
    :primary_key => :id,
    :dependent => :destroy
  )

  has_many(
    :responses,
    :through => :answer_choices,
    :source => :responses
  )

  def results
    results = Hash.new(0)
    query_string = "answer_choices.*, COUNT(responses.id) AS response_count"
    join_string = <<-FART
                      LEFT OUTER JOIN responses ON answer_choices.id =
                      responses.answer_choice_id
                    FART
    where_string = "answer_choices.question_id = #{self.id}"

    choices = AnswerChoice.select(query_string)
                          .joins(join_string)
                          .where(where_string)
                          .group("answer_choices.id")

    choices.each do |choice|
      results[choice.text] = choice.response_count
    end

    results
  end
end
