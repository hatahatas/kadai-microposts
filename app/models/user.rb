class User < ApplicationRecord
    before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    
    has_secure_password
    
  has_many :microposts
  has_many :relationships
  has_many :like_microposts
  has_many :likes, through: :like_microposts, source: :micropost
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  
    def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
    end 

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end

  def liked(micropost)
     self.like_microposts.find_or_create_by(micropost_id: micropost.id)
  end 
  
  def unliked(micropost)
    like_micropost = self.like_microposts.find_by(micropost_id: micropost.id)
    like_micropost.destroy if like_micropost
  end 
  
  def likes?(micropost)
    self.likes.include?(micropost)
  end 
  
  
end
