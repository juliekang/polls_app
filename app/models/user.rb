class User < ActiveRecord::Base
  attr_accessible :user_name
  validates :user_name, :presence => true, :uniqueness => true

  has_many(
    :authored_polls,
    :class_name => "Poll",
    :foreign_key => :author_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name => "Response",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  def completed_polls
    get_my_polls.first
  end

  def get_my_polls
    completed = []
    uncompleted = []

    polls = Poll.select("polls.*, COUNT(responses.id) AS response_count")
                .joins(:questions => :responses)
                .where("responses.user_id = #{self.id}")
                .group("polls.id")

    polls.each do |poll|
      if poll.response_count == poll.questions.length
        completed << poll.title
      else
        uncompleted << poll.title
      end
    end

    [completed, uncompleted]
  end

  def uncompleted_polls
    get_my_polls.last
  end
end
