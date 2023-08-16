class Activity < ApplicationRecord
  belongs_to :container
  belongs_to :user
  has_many :logs
  has_many :items

  enum activity_type: [:quote_form, :inspection_form, :repair_form]
  enum activity_status: [ :quote_draft, :quote_pending, :quote_issued, :quote_approved,:repair_draft ,:repair_pending, :repair_done ,:inspection_draft ,:inspection_done ,:ready_for_billing , :billed ,:void]
end
