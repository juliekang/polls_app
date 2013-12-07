has_one(
  :question,
  :through => :answer_choice,
  :source => :question
)


# def existing_responses
#   where = "users.id = #{self.user_id} AND questions.id = #{self.question.id}"
#   User.select("users.*, COUNT(responses.id) AS response_count")
#       .joins(:authored_polls => {:questions => :responses})
#       .where(where)
# end

users = User.joins(:authored_polls => {:questions => :responses}).where("answer_choices.id = ? AND responses.id = ?", 3, 4)