class Model < ActiveRecord::Base
  validates :name,     presence: true, uniqueness: true
  validates :equation, presence: true

  has_many  :variables do
    def populate
      symbols_from_equation.each do |symbol|
        find_or_create_by symbol: symbol
      end
    end

    def symbols_from_equation
      proxy_association.owner.equation.scan(/\[(.*?)\]/).flatten.uniq
    end
  end
end
