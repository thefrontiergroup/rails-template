require 'rails_helper'

class DummyClass
end

describe TfgTemplate do
  include TfgTemplate

  it { TfgTemplate.setting["first_key"] == "first" }
  it { TfgTemplate.setting["second_key"] == "second" }
end
