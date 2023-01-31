class Otype < ApplicationRecord
    has_many :operations
    validates :title, presence: true
    validates :title, uniqueness: true
    validates :title, length: {maximum: 255}
end
