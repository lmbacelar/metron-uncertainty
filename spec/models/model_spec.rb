require 'spec_helper'
require_relative '../../lib/r_expression_validator.rb'

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
      it 'validates equation as a proper R expression' do
        expect_any_instance_of(RExpressionValidator).to receive(:validate_each).once.with(model, :equation, model.equation)
        model.valid?
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
          expect(model).not_to receive(:update_variables)
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
          expect(model).to receive(:update_variable).exactly(2).times
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

  describe 'scopes' do
    describe 'recent' do
      before(:each) do
        (1..13).each { |i| Model.create! name: i, equation: '[x]' }
      end

      it 'displays 12 most recent models' do
        expect(Model.recent.count).to eq 12
      end

      it 'displays models in reverse chronological order' do
        expect(Model.recent.first.name).to eq '13'
        expect(Model.recent.last.name).to  eq '2'
      end
    end
  end

end
