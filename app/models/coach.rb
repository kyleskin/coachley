class Coach < User
  has_many :reps
  belongs_to :manager
end
