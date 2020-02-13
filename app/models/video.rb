class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.bookmarks(user_id)
    Tutorial.joins(videos: [:users])
            .select('videos.*, tutorials.title, users.id')
            .where("users.id = #{user_id}")
            .order('tutorial_id, position')
  end
end
