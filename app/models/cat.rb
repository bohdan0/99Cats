class Cat < ActiveRecord::Base
  validates :birth_date, :color, :sex, :name, :description, presence: true
  validates :color, inclusion: { in: %w(black white red green),
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests, dependent: :destroy

end
