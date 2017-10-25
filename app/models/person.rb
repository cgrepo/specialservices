class Person < ActiveRecord::Base
    has_one :responsable, dependent: :destroy
    has_many :relatives, dependent: :destroy
end
