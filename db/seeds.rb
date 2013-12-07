# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  u1 = User.create!(user_name: "Julie")
  u2 = User.create!(user_name: "Brian")
  u3 = User.create!(user_name: "Jeff")

  p1 = Poll.create!(title: "Lunch", author_id: 1)

  q1 = Question.create!(text: "What time do you want to eat?", poll_id: 1)
  q2 = Question.create!(text: "What type of food?", poll_id: 1)
  q3 = Question.create!(text: "What do you want to drink?", poll_id: 1)

  c1 = AnswerChoice.create!(text: "12:00", question_id: 1)
  c2 = AnswerChoice.create!(text: "12:30", question_id: 1)
  c3 = AnswerChoice.create!(text: "1:00", question_id: 1)
  c4 = AnswerChoice.create!(text: "Mexican", question_id: 2)
  c5 = AnswerChoice.create!(text: "Sushi", question_id: 2)
  c6 = AnswerChoice.create!(text: "Beer", question_id: 3)

  r1 = Response.create!(user_id: 2, answer_choice_id: 1)
  r2 = Response.create!(user_id: 2, answer_choice_id: 4)
  r3 = Response.create!(user_id: 2, answer_choice_id: 6)
  r4 = Response.create!(user_id: 3, answer_choice_id: 2)
  r5 = Response.create!(user_id: 3, answer_choice_id: 5)
end