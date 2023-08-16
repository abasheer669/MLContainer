class Log < ApplicationRecord
  belongs_to :activity
  belongs_to :user


  enum log_status: [:created,
    :quote_draft,
    :quote_pending,
    :quote_issued,
    :quote_approved,
    :repair_pending,
    :repair_done,
    :inspection_draft,
    :inspection_done,
    :ready_for_billing,
    :billed,
    :void]
end
