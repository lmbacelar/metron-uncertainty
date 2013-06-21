require 'rserve/simpler/R'
require 'active_model'
require_relative '../../lib/r_expression_validator'

class Model
  include ActiveModel::Validations
  attr_accessor :expression
  validates :expression, r_expression: true
end

describe RExpressionValidator do
  let(:model) { Model.new }

  context 'with a valid r expression' do
    it 'is valid' do
      model.stub(:expression).and_return('X$a')
      expect(model).to be_valid
    end
  end

  context 'with an invalid r expression' do
    it 'has one error on expression' do
      model.stub(:expression).and_return('X$a + (')
      expect(model).not_to be_valid
      expect(model.errors[:expression].length).to eq 1
    end
  end
end
