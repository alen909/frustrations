class Comment < ActiveRecord::Base
  belongs_to :frustration
  belongs_to :user

  validates :body, presence: true
  validates :frustration_id, presence: true
end
