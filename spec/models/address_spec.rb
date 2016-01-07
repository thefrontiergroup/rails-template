require 'rails_helper'

RSpec.describe Address, type: :model do

  describe "@line_1" do
    it { should validate_presence_of(:line_1) }
  end

  describe "@state_id" do
    it { should validate_presence_of(:state_id) }
  end

  describe "@post_code" do
    it { should validate_presence_of(:post_code) }
  end

end
