class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, 
            presence: true, 
            length: { maximum: 25 },
            format: { with: /\A[a-zA-Z\s]+\z/i, message: "only allows letters" }

  validates_presence_of :target_date

  validates_uniqueness_of :title, scope: :user_id

  def ransackable_attributes(auth_object = nil)
    ["title"]
  end
end
