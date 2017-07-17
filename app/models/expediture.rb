class Expediture < ActiveRecord::Base
  belongs_to :person
  has_many :otherExpediture
end
