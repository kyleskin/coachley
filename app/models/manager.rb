class Manager < User
  has_many :coaches
  has_many :reps, through: :coaches
end
