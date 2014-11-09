class DocumentRoute < ActiveRecord::Base
  validates :document_id, :office_id, presence: true

  enum status: { incoming: 0, received: 1, released: 2, rejected: 3, completed: 4 }

  belongs_to :document
  belongs_to :office
  belongs_to :next_route, class_name: "Office"

  def receive!
    self.update! date_in: Time.now, status: :received
    Notification.location self
  end

  def release!(route)
    self.update! date_out: Time.now, next_route_id: route.id, status: :released
    Notification.motion route
  end

  def reject!
    self.update! date_out: Time.now, status: :rejected
    self.document.rejected!
    Notification.rejection self
  end

  def complete!
    self.update! date_out: Time.now, status: :completed
    self.document.approved!
    Notification.completion self
  end
end
