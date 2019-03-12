class TrainerCandidate < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :introduce, presence: true, length: {maximum: Settings.max_email}
  validates :cv_url, presence: true, length: {maximum: Settings.max_email}
  validates_uniqueness_of :user_id, scope: %i(course_id)
end
