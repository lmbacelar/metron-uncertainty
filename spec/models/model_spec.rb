require 'spec_helper'

describe Model do
  let(:model) do
    Model.new(name: 'name', description: 'desc', equation: '[a] + [b]')
  end
  describe 'attributes' do
    describe 'validations' do
      it 'requires name to be present' do
        expect(model).to validate_presence_of :name
      end
      it 'requires name to be unique' do
        model.save!
        expect(model).to validate_uniqueness_of :name     
      end
      it 'requires equation to be present' do
        expect(model).to validate_presence_of :equation
      end
    end

    it 'gets unique variable names from equation' do
      model.equation = "( [x] + [y] ) / ( [z] - [x] )"
      expect(model.variable_names).to eq ['x','y','z']
    end

    it 'saves attributes' do
      model.save!
      expect(model).to be_valid
    end
  end
end