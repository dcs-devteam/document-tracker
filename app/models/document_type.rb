class DocumentType < ActiveRecord::Base
  validates :name, :route, presence: true

  scope :alive, -> { where(erased: false) }

  def offices
    offices = []
    self.route.split(",").each do |office_id|
      offices << Office.find(office_id) if Office.exists? office_id
    end
    offices
  end
end
