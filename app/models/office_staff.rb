class OfficeStaff < ActiveRecord::Base
  validates :name, :office_id, presence: true

  belongs_to :office

  default_scope -> { where(active: true) }
end
