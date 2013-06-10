class Variable < ActiveRecord::Base
  validates  :symbol, presence: true, uniqueness: { :scope => :model }
  belongs_to :model
end
