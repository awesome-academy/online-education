class Course < ApplicationRecord
  has_many :course_tags, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :purchased_courses, class_name: PurchasedCourse.name,
    foreign_key: :course_id, dependent: :destroy
  has_many :tags, through: :course_tags
  has_many :trainer_candidates, dependent: :destroy
  belongs_to :trainer, class_name: User.name,
    foreign_key: :user_id, optional: true
  has_many :users, through: :purchased_courses, dependent: :destroy

  validates :course_status, presence: true
  validates :description, length: {maximum: Settings.text_max}
  validates :name, presence: true, length: {maximum: Settings.string_max},
    uniqueness: {case_sensitive: true}

  enum course_status: {recruiting: 0, building: 1, complete: 2}

  scope :course_in_recruitment, ->{where course_status: :recruiting}
end
