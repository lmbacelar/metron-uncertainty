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

    describe 'variables' do
      before(:each) { model.save! }

      context 'new equation' do
        it 'creates variables' do
          expect(model.variables.count).to eq 2
        end
      end

      context 'equation unchanged' do
        it 'does not trigger variables update' do
          model.should_not_receive :update_variables
          model.save!
        end
      end

      context 'equation changed' do
        it 'keeps existing variables' do
          a = model.variables.find_by symbol: 'a'
          model.equation = '2 * [a]'
          model.save!
          expect(model.variables.first).to eq a
        end
        it 'destroys unused variables' do
          model.equation = '2 * [a]'
          model.save!
          expect(model.variables.count).to eq 1
        end
        it 'updates each variable once' do
          model.equation = '( [a]*[a] ) / [b]'
          model.should_receive(:update_variable).exactly(2).times
          model.save!
        end
      end

      context 'equation destroyed' do
        it 'destroys all variables' do
          vars = model.variables
          model.destroy
          expect(vars.count).to eq 0
        end
      end
    end
  end

end
