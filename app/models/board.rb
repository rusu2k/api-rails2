class Board < ApplicationRecord
    #attr_reader :user_id

    validates :title, presence: true, length: { minimum: 3 }
    has_many :columns, -> { order(position: :asc) }, dependent: :destroy
    belongs_to :user

end
