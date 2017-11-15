class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id, message: 'Duplicate post title' }
  validates :body, presence: true
  validates :flagged, inclusion: { in: [false, true] }

  before_validation :default_values

  private

    def default_values
      self.flagged ||= false if self.flagged.nil?
    end
end
