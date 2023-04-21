class Board < ApplicationRecord
    validates :title, presence: true, length: { minimum: 3 }
    has_many :columns, -> { order(position: :asc) }, dependent: :destroy

end
