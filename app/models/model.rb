class Model < ActiveRecord::Base
  validates :name,     presence: true, uniqueness:   true
  validates :equation, presence: true, r_expression: true

  scope :recent, -> { order(:created_at).reverse_order.limit(12) }

  has_many  :variables, dependent: :destroy

  after_save :update_variables, if: :equation_changed?

  protected
  def update_variables
    variables.where.not(symbol: equation_symbols).destroy_all
    equation_symbols.each { |s| update_variable s }
  end

  private
  def update_variable s
    variables.find_or_create_by symbol: s
  end

  def equation_symbols
    equation.scan(/X\$(\w*)/).flatten.uniq
  end
end
