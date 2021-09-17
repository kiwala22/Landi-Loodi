class Contract < ApplicationRecord
  belongs_to :tenant
  belongs_to :rental
end
