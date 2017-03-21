class Target < ApplicationRecord
  validates :objective, presence: true,
                        length: { minimum: 10 }

  validates :due_date,  presence: true
end
