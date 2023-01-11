class Category < ApplicationRecord
    has_many :operations
    validates :name, :description, presence: true
    validates :name, uniqueness: true
end
