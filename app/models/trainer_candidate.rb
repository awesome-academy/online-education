class TrainerCandidate < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :introduce, presence: true, length: {maximum: Settings.max_email}
  validates :cv_url, presence: true, length: {maximum: Settings.max_email}
  validate :user_cant_apply_twice

  private

  def user_cant_apply_twice
    return unless user_id.present? && course_id.present?
    errors.add :course, I18n.t(".cant_apply_twice")
  end
end
