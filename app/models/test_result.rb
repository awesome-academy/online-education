class TestResult < ApplicationRecord
  has_many :user_answers
  belongs_to :test, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
