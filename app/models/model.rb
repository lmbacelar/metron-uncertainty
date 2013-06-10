class Model < ActiveRecord::Base
  validates :name,     presence: true, uniqueness: true
  validates :equation, presence: true

  def variable_names
    equation.scan(/\[(.*?)\]/).flatten.uniq
  end
end
