class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

         has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
         has_many :followees, through: :followed_users
        
         has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
         has_many :followers, through: :following_users
       
         def follow(user)
           followed_users.create(followee_id: user.id)
         end
       
         def unfollow(user)
           followed_users.find_by(followee_id: user.id).delete
         end

         has_many :posts
          
         has_one_attached :avatar
end

