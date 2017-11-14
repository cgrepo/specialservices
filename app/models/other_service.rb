class OtherService < ActiveRecord::Base
  belongs_to :living_place
  HUMANIZED_ATTRIBUTES = { :name => 'Servicio' }
  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  validates :name, presence: { message: "los datos, no puede estar en blanco" }
end
