class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }
  validates :due_date, presence: true
  validates :mood, presence: true
end
