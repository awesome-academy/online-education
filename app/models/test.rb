class Test < ApplicationRecord
  has_one :lesson
  has_many :test_result, dependent: :destroy
  has_many :test_questions, dependent: :destroy
  has_many :questions, through: :test_questions
end
