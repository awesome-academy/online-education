class Lesson < ApplicationRecord
  belongs_to :course
  has_one :test
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.string_max},
    uniqueness: {case_sensitive: true}
  validates :video_url, presence: true, length: {maximum: Settings.string_max}

  scope :lessons_sort, ->{order created_at: :desc}
end
