class Office < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  
  scope :alive, -> { where(erased: false) }

  has_many :office_staffs, dependent: :destroy
  has_many :document_types, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :document_routes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications

  def active_for_authentication?
    super and !self.erased
  end

  def admin?
    self.admin
  end

  def superadmin?
    self.superadmin
  end

  def toggle_admin!
    self.update! admin: !self.admin
  end

  def turnaround_time
    documents = self.document_routes.released + self.document_routes.completed + self.document_routes.rejected
    if documents.any?
      total = 0
      documents.each do |document|
        total += document.date_out - document.date_in
      end
      total /= documents.count
      seconds = total.round
      if seconds >= 60
        minutes = seconds % 60
        seconds /= 60
      end
      if seconds >= 60
        hours = minutes % 60
        minutes /= 60
      end

      time = []
      time << "#{hours} hours" if hours
      time << "#{minutes} minutes" if minutes
      time << "#{seconds} seconds" if seconds
      return time.join ", "
    end
    return "Cannot be determined"
  end
end
