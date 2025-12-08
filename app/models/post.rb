class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"

  has_many :likes, dependent: :destroy, class_name: "PostLike"
  has_many :comments, dependent: :destroy, class_name: "PostComment"

  validates :title, presence: true, length: { minimum: 1 }
  validates :body, presence: true, length: { minimum: 50 }
end
