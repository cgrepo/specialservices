class LivingPlace < ActiveRecord::Base
  belongs_to :person
  has_many :otherService
end
