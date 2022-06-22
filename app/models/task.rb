class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user
  
  attribute :status, :boolean, default: false

  validates :title, 
            presence: true, 
            length: { maximum: 25 },
            format: { with: /\A[a-zA-Z\s]+\z/i, message: "only allows letters" }

  validates :body, presence: true

  validates_uniqueness_of :title, scope: :category_id

  def ransackable_attributes(auth_object = nil)
    ["title", "status"]
  end
end
