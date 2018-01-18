class LivingPlace < ActiveRecord::Base
  belongs_to :person
  has_many :OtherService, dependent: :destroy
end
