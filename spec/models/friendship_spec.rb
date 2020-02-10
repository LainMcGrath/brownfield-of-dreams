require 'rails_helper'

RSpec.describe Friendship do
  describe "relationships" do
    it { should belong_to :user }
  end
end
