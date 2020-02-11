require 'rails_helper'

RSpec.describe Follow do
  describe "relationships" do
    it { should belong_to :user }
  end
end
