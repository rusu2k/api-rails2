class Story < ApplicationRecord
  belongs_to :column

  default_scope { order(title: :asc) }

    scope :to_do, -> { where(status: 1) }
    scope :in_progress, -> { where(status: 2) }
    scope :solved, -> { where(status: 3) }
    

    scope :old, -> { where('created_at < ?', Date.today - 30) }
    scope :overdue, -> { where('due_date < ?', Date.today) }
end
