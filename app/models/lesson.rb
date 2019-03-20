class Lesson < ApplicationRecord
  has_one :test
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :course
  scope :lessons_sort, ->{order created_at: :desc}
  validates :name, presence: true, length: {maximum: Settings.string_max},
    uniqueness: {case_sensitive: true}
  validates :video_url, presence: true, length: {maximum: Settings.string_max}
end
