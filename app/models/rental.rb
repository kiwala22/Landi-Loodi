class Rental < ApplicationRecord
    has_one :contract

    validates_presence_of :rental_number, message: "House Number is required."
    validates_presence_of :rent_amount, message: "Rent Amount is required."
    validates_presence_of :status, message: "House Status is required."
    validates_uniqueness_of :rental_number, message: "House Number already taken."
end
