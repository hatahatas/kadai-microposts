class Micropost < ApplicationRecord
  belongs_to :user
  
validates :content, presence: true, length: { maximum: 255 }

has_many :like_microposts
has_many :favorited, through: :like_microposts, source: :user
  
end
