class Role < ApplicationRecord
    has_many :access_controls
    has_many :permissions, through: :access_controls
    has_many :users
end
