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
      it 'validates equation' do
        pending
      end
    end
    it 'saves attributes' do
      model.save!
      expect(model).to be_valid
    end
  end

  describe 'relations' do
    it 'has many variables' do
      expect(model).to have_many :variables
    end
    it 'populates variables defined on equation' do
      model.save!
      expect(model.variables.populate).to eq ['a','b']
      expect(model.variables.length).to eq 2
    end
  end

  xit 'gets unique variable names from equation' do
    model.equation = "( [x] + [y] ) / ( [z] - [x] )"
    expect(model.variable_names).to eq ['x','y','z']
  end
end
