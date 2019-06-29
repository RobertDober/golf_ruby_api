class Debit < ApplicationRecord
  scope :for_union, -> { select(:amount, :label, "'debit' as type") }
end
