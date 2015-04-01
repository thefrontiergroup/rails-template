require 'spec_helper'

describe User do

  describe '@role' do
    it { should validate_presence_of(:role) }
  end

end
