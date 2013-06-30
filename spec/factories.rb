FactoryGirl.define do
  sequence(:description) do
    Lorem::Base.new(:paragraphs, 1).output
  end
  
  factory :model do
    sequence(:name) { |n| "model #{n}" }
    description
    equation 'X$a + X$b'
  end
end
