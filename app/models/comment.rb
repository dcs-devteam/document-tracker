class Comment < ActiveRecord::Base
  validates :body, :office_id, :document_id, presence: true

  enum user_role: { as_office: 0, as_staff: 1, as_admin: 2 }

  scope :alive, -> { where(erased: false) }

  belongs_to :office
  belongs_to :document
end
