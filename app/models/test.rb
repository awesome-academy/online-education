class Test < ApplicationRecord
  belongs_to :lesson
  has_many :test_result, dependent: :destroy
  has_many :test_questions, dependent: :destroy
  has_many :questions, through: :test_questions
end
