class Follow < ApplicationRecord
  belongs_to :followee, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  def self.create_friendship(friend_were_following_id, current_user_id)
    user_were_following = User.find_by(uid: friend_were_following_id)
    create(followee_id: user_were_following.id, follower_id: current_user_id)
  end
end