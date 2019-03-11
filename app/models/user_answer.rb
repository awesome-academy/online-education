class UserAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :test_result
end
