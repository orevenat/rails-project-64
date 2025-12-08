class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :creator, class_name: "User"

  validates :creator_id, uniqueness: { scope: :post_id }
end
