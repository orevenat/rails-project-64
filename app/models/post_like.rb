class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: "creator_id"

  validates :creator_id, uniqueness: { scope: :post_id }
end
