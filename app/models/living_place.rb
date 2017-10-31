class LivingPlace < ActiveRecord::Base
  belongs_to :Person
  has_many :OtherService
end
