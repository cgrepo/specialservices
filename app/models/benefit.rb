class Benefit < ActiveRecord::Base
  belongs_to :person
  
  HUMANIZED_ATTRIBUTES = {
    :amount => 'Cantidad'
  }
  
  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  validates :amount, presence: { message: "no puede estar en blanco" }
end
