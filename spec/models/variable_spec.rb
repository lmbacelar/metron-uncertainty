require 'spec_helper'

describe Variable do
  let(:variable) { Variable.new }

  describe 'attributes' do
    describe 'validations' do
      it 'requires symbol to be present' do
        expect(variable).to validate_presence_of :symbol
      end
      it 'requires symbol to be unique for each model' do
        expect(variable).to validate_uniqueness_of(:symbol).scoped_to(:model_id)
      end
    end
  end

  describe 'relations' do
    it 'belongs to a model' do
      expect(variable).to belong_to :model
    end
  end
end
