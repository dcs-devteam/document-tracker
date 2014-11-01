class DocumentType < ActiveRecord::Base
  validates :name, :route, presence: true

  scope :alive, -> { where(erased: false) }
  scope :defaults, -> { where(owner_id: nil) }
  scope :by, -> (office) { where(owner_id: office.id) }
  scope :usable_by, -> (office) { defaults.alive + by(office).alive }

  belongs_to :owner

  def offices
    offices = []
    self.route.split(",").each do |office_id|
      offices << Office.find(office_id) if Office.exists? office_id
    end
    offices
  end

  def owned_by?(office)
    self.owner_id == office.id
  end
end
