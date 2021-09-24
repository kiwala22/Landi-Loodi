class Payment < ApplicationRecord
  belongs_to :rental
  belongs_to :admin

  validates_presence_of :amount, message: "Amount is required."
  validates_presence_of :date, message: "Payment Date is required."
  validates_presence_of :remarks, message: "Payment Remarks is required."
  validates_presence_of :rental_id, message: "House Number is required."

  validates_uniqueness_of :payment_reference, message: "Payment Reference already Taken."
end
