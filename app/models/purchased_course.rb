class PurchasedCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :user_id, scope: %i(course_id)
end
