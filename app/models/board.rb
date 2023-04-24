class Board < ApplicationRecord
    acts_as_paranoid
    has_paper_trail(
        meta: { user_id: :user_id },
        versions: { class_name: 'BoardVersion' }
        )
    validates :title, presence: true, length: { minimum: 3 }
    has_many :columns, -> { order(position: :asc) }, dependent: :destroy
    belongs_to :user

end
