class Model < ActiveRecord::Base
  validates :name,     presence: true, uniqueness: true
  validates :equation, presence: true

  has_many  :variables, dependent: :destroy

  after_save :update_variables, if: :equation_changed?

  protected
  def update_variables
    variables.where.not(symbol: equation_symbols).destroy_all
    equation_symbols.each { |s| update_variable s }
  end

  private
  def equation_symbols
    equation.scan(/\[(.*?)\]/).flatten.uniq
  end

  def update_variable s
    variables.find_or_create_by symbol: s
  end
end
