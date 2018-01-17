class Person < ActiveRecord::Base
    mount_uploader :picture, MyPictureUploader
    has_one  :responsable, dependent: :destroy
    has_many :relatives,   dependent: :destroy
    has_one  :LivingPlace, dependent: :destroy
    has_many :Expediture,  dependent: :destroy
    has_many :Benefit,     dependent: :destroy
end
