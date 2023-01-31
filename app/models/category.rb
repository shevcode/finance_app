class Category < ApplicationRecord
    has_many :operations
    validates :name, :description, presence: true
    validates :name, uniqueness: true
    validates :name, :description, length: {maximum: 255}
    paginates_per 10
end
