class Tenant < ApplicationRecord
    has_one :contract

    validates_presence_of :surname, message: "Surname is required."
    validates_presence_of :other_names, message: "Other Names is required."
    validates_presence_of :marital_status, message: "Marital Status is required."
    validates_presence_of :phone_number, message: "Phone Number is required."
    validates_presence_of :id_number, message: "ID Number is required."
    validates_uniqueness_of :phone_number, message: "Phone Number already taken."
    validates_uniqueness_of :id_number, message: "ID Number already taken."
end
