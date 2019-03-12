class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :purchased_courses, class_name: PurchasedCourse.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :courses, through: :purchased_courses
  has_many :questions
  has_many :trainer_courses, class_name: Course.name, foreign_key: :user_id
  has_many :test_result, dependent: :destroy
  has_many :trainer_candidates, dependent: :destroy
  enum user_type: {trainee: 0, trainer: 1, admin: 2}

  before_save :email_downcase

  validates :email, presence: true, length: {maximum: Settings.max_email},
                    format: {with: URI::MailTo::EMAIL_REGEXP},
                    uniqueness: {case_sensitive: false}
  validates :first_name, presence: true,
    length: {maximum: Settings.max_first_name}
  validates :last_name, presence: true,
    length: {maximum: Settings.max_last_name}
  validates :password, allow_nil: true,
    length: {minimum: Settings.min_password}

  has_secure_password

  def current_user? user
    self == user
  end

  private

  def email_downcase
    email.downcase!
  end
end
