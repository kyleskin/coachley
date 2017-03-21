class Target < ApplicationRecord
  belongs_to :user
  validates :objective, presence: true,
                        length: { minimum: 10 }

  validates :due_date,  presence: true
end
