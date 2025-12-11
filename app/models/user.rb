class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy, foreign_key: :creator_id, inverse_of: :creator
  has_many :likes, dependent: :destroy, inverse_of: :user, class_name: "PostLike"
  has_many :comments, dependent: :destroy, inverse_of: :user, class_name: "PostComment"
end
