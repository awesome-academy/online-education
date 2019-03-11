class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :courses, through: :purchased_courses, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :purchased_courses, class_name: PurchasedCourse.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :trainer_courses, class_name: Course.name, foreign_key: :user_id
  has_many :test_result, dependent: :destroy
  has_many :trainer_candidates, dependent: :destroy
end
