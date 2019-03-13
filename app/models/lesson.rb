class Lesson < ApplicationRecord
  has_one :test
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :course
end
