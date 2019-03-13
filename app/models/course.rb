class Course < ApplicationRecord
  has_many :course_tags, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :purchased_courses, class_name: PurchasedCourse.name,
    foreign_key: :course_id, dependent: :destroy
  has_many :trainer_candidates, dependent: :destroy
  has_many :users, through: :purchased_courses, dependent: :destroy
  belongs_to :trainer, class_name: User.name,
    foreign_key: :user_id, optional: true
end
