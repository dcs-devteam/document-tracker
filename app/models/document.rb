class Document < ActiveRecord::Base
  validates :name, :document_type_id, :office_id, :owner, :tracking_number, presence: true
  validates :tracking_number, uniqueness: true

  enum status: { onhold: 0, pending: 1, approved: 2, rejected: 3 }

  scope :alive, -> { where(erased: false) }
  scope :by, -> (office) { where(office_id: office.id) }

  belongs_to :office
  belongs_to :document_type

  before_validation :generate_tracking_number

  private

    def generate_tracking_number
      count = self.class.count
      tracking_number = nil
      while !tracking_number or self.class.where(tracking_number: tracking_number).any?
        count += 1
        digits = count > 1 ? Math.log10(count) : 1
        padding = "0" * ([4, digits].max - digits)
        tracking_number = padding + count.to_s
      end
      self.tracking_number = tracking_number
    end
end
