class OtherExpediture < ActiveRecord::Base
  belongs_to :Expediture
  HUMANIZED_ATTRIBUTES = {
  	:name => 'Gasto',
  	:amount => 'Monto'
  }
  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  validates :name, :amount, presence: { message: "los datos, no puede estar en blanco" }
end
