class Payment < ApplicationRecord
  belongs_to :rental
  belongs_to :admin
end
