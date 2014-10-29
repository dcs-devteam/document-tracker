class OfficeStaff < ActiveRecord::Base
  validates :name, :office_id, presence: true

  belongs_to :office
end
