class Frustration < ActiveRecord::Base
  belongs_to :user
  mount_uploader :cover, CoverUploader
  validates :title, presence: true
  validates :body, presence: true
  has_many  :comments, dependent: :destroy
end
