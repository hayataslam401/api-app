class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many_attached :images
end
