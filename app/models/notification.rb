class Notification < ActiveRecord::Base
  validates :office_id, :body, :role, presence: true

  enum role: { office: 0, staff: 1, admin: 2 }

  belongs_to :office

  def seen!
    self.update! seen: true
  end

  def self.comment(comment)
    comment.document.involved_offices.each do |office|
      unless office[0] == comment.office
        self.create(
          office_id: office[0].id,
          body: "<strong>#{comment.office.name}</strong> commented on the document <strong>#{comment.document.name}</strong>.",
          link: self.resolve_link(comment.document, office[1]),
          role: office[1]
        )
      end
    end
  end

  def self.location(route)
    self.create(
      office_id: route.document.office.id,
      body: "<strong>#{route.office.name}</strong> has received your document <strong>#{route.document.name}</strong>.",
      link: self.resolve_link(route.document, :office),
      role: :office
    )
  end

  def self.motion(route)
    self.create(
      office_id: route.document.office.id,
      body: "Your document <strong>#{route.document.name}</strong> is on its way to <strong>#{route.office.name}</strong>.",
      link: self.resolve_link(route.document, :office),
      role: :office
    )
    self.create(
      office_id: route.office.id,
      body: "The document <strong>#{route.document.name}</strong> is on its way to your office.",
      link: self.resolve_link(route.document, :staff),
      role: :staff
    )
  end

  def self.completion(route)
    self.create(
      office_id: route.document.office.id,
      body: "<strong>#{route.office.name}</strong> approved your document <strong>#{route.document.name}</strong>.",
      link: self.resolve_link(route.document, :office),
      role: :office
    )
  end

  def self.rejection(route)
    self.create(
      office_id: route.document.office.id,
      body: "<strong>#{route.office.name}</strong> rejected your document <strong>#{route.document.name}</strong>.",
      link: self.resolve_link(route.document, :office),
      role: :office
    )
  end

  def self.toggle_admin(office)
    self.create(
      office_id: office.id,
      body: office.admin? ? "You have been granted admin privileges." : "Your admin privileges has been revoked.",
      role: :office
    )
  end

  def to_json
    super only: [:body, :link]
  end

  private

    def self.resolve_link(document, role)
      if role == :office
        Rails.application.routes.url_helpers.document_path document
      elsif role == :staff
        Rails.application.routes.url_helpers.office_document_path document
      elsif role == :admin
        Rails.application.routes.url_helpers.admin_document_path document
      end
    end
end
