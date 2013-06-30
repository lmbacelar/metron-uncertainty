class Model < ActiveRecord::Base
  validates :name,     presence: true, uniqueness:   true
  validates :equation, presence: true, r_expression: true
  validates :url,      presence: true

  scope :recent, -> { order(:created_at).reverse_order.limit(12) }

  has_many  :variables, -> { order(:created_at) }, dependent: :destroy

  after_save :update_variables, if: :equation_changed?

  acts_as_url :name, sync_url: true

  def to_param
    url
  end

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
