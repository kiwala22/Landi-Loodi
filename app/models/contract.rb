class Contract < ApplicationRecord
  belongs_to :tenant
  belongs_to :rental

  validates_presence_of :start_date, message: "Start Date is required."
  validates_presence_of :end_date, message: "End Date is required."
  validates_presence_of :tenant_id, message: "Tenant Name is required."
  validates_presence_of :rental_id, message: "House Number is required."
end
