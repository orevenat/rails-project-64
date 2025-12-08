class PostComment < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :post

  has_ancestry
end
