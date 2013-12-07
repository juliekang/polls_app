class AnswerChoice < ActiveRecord::Base
  attr_accessible :text, :question_id
  validates :text, :question_id, :presence => true

  belongs_to(
    :question,
    :class_name => "Question",
    :foreign_key => :question_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name => "Response",
    :foreign_key => :answer_choice_id,
    :primary_key => :id,
    :dependent => :destroy
  )
end
