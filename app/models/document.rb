class Document < ActiveRecord::Base
  validates :name, :document_type_id, :office_id, :owner, :tracking_number, presence: true
  validates :tracking_number, uniqueness: true

  enum status: { onhold: 0, pending: 1, approved: 2, rejected: 3 }

  scope :alive, -> { where(erased: false) }
  scope :by, -> (office) { where(office_id: office.id) }

  belongs_to :office
  belongs_to :document_type
  has_many :document_routes

  before_validation :generate_tracking_number

  def deviated_from_suggested_path?
    current_path = self.document_routes.map { |r| r.office_id }.join ","
    !self.document_type.route.match /^#{current_path}/
  end

  def suggested_next_route
    unless self.deviated_from_suggested_path? or self.approved? or self.rejected?
      current_path = self.document_routes.map { |r| r.office_id }.join ","
      remaining_path = self.document_type.route.gsub(/^#{current_path},?/, "").split ","
      if remaining_path.any?
        Office.find remaining_path.first
      end
    end
  end

  def accessible_to?(office)
    self.office == office or self.document_routes.map { |r| r.office_id }.include? office.id
  end

  private

    def generate_tracking_number
      if self.new_record?
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
end
