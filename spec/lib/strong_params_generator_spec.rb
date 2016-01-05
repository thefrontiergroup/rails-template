require 'rails_helper'

class TestModel
end

class TestModelParams
  def initialize(user, object)
  end

  def permitted_attributes
    ["one"]
  end
end

class OtherModel
end

RSpec.describe StrongParamsGenerator do

  describe '#permitted_attributes' do
    subject { generator.permitted_attributes }
    let(:generator) { StrongParamsGenerator.new(user, resource) }
    let(:user) { Object.new }

    context "with an existing strong params class" do
      context "passing the class" do
        let(:resource) { TestModel }
        it { should eq(TestModelParams.new(nil, nil).permitted_attributes) }
      end

      context "passing an instance" do
        let(:resource) { TestModel.new }
        it { should eq(TestModelParams.new(nil, nil).permitted_attributes) }
      end
    end

    context "with no existing strong params class" do
      let(:resource) { OtherModel.new }

      it "raises an error" do
        expect { subject }.to raise_error(NameError)
      end
    end
  end

end
