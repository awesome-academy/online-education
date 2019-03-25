class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :test_questions, dependent: :destroy
  has_many :test, through: :test_questions
  has_many :user_answers, dependent: :destroy
  belongs_to :trainer, class_name: User.name, foreign_key: :user_id,
    optional: true
  accepts_nested_attributes_for :answers

  scope :questions_sort, ->{order created_at: :desc}
end
