require 'rails_helper'

RSpec.describe Video do
  describe 'relationships' do
    it {should have_many :user_videos}
    it {should have_many(:users).through(:user_videos)}
    it {should belong_to :tutorial}
  end

  describe 'validations' do
    it { should validates_presence_of :title }
    it { should validates_presence_of :description }
    it { should validates_presence_of :youtube_id }
  end
end
