require 'spec_helper'

describe Model do
  let(:model)          { FactoryGirl.build :model, name: 'name of model' }
  let(:another_model)  { FactoryGirl.build :model, name: 'name-of-model' }

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
    describe 'url slug' do
      it 'is created when saving model' do
        model.save!
        expect(model.url).to eq 'name-of-model'
      end
      it 'is updated when model name changes' do
        model.save!
        model.name = 'another model name'
        model.save!
        expect(model.url).to eq 'another-model-name'
      end
      it 'is unique' do
        model.save!
        another_model.save!
        expect(model.url).not_to eq another_model.url
      end
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
          model.equation = '2 * X$a'
          model.save!
          expect(model.variables.first).to eq a
        end
        it 'destroys unused variables' do
          model.equation = '2 * X$a'
          model.save!
          expect(model.variables.count).to eq 1
        end
        it 'updates each variable once' do
          model.equation = '( X$a*X$a ) / X$b'
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
      before(:each) { FactoryGirl.create_list :model, 13 }

      it 'displays 12 most recent models' do
        expect(Model.recent.count).to eq 12
      end

      it 'displays models in reverse chronological order' do
        expect(Model.recent.first.created_at).to be > Model.recent.last.created_at
      end
    end
  end

  describe '#to_param' do
    it 'should return url' do
      model.valid?
      expect(model.to_param).to eq model.url
    end
  end

end
