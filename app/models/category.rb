class Category < ApplicationRecord
    has_many :operations
    validates :name, :description, presence: true
    validates :name, uniqueness: true
    paginates_per 10
end
