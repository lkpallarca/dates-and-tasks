class Task < ApplicationRecord
  belongs_to :category
  
  attribute :status, :boolean, default: false

  validates :title, 
            presence: true, 
            length: { maximum: 25 },
            format: { with: /\A[a-zA-Z\s]+\z/i, message: "only allows letters" }

  validates :body, presence: true

  validates_uniqueness_of :title, scope: :category_id
end
