class User < ApplicationRecord
	validates :name, presence: true, length: { maximum: 20 }
	validates :speed, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_blank: true }
end
