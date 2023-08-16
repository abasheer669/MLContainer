class Customer < ApplicationRecord
  enum customer_type: [:maersk, :non_maersk]
  enum customer_status: [:active, :inactive]

  has_many :containers
end
