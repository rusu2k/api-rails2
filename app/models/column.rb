class Column < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }

  belongs_to :board
  has_many :stories, -> {order(due_date: :asc)}, dependent: :destroy
end
