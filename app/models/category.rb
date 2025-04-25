class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :body, presence: true, length: { minimum: 5 }
end