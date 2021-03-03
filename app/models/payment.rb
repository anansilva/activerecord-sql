class Payment < ApplicationRecord
  belongs_to :booking

  enum status: %w[pending confirmed]
end
