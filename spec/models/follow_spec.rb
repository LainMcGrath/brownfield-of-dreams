require 'rails_helper'

RSpec.describe Follow do
  describe "relationships" do
    it { should belong_to :followee }
    it { should belong_to :follower }
  end
end
