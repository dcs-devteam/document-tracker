class Office < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  
  scope :alive, -> { where(erased: false) }

  has_many :office_staffs, dependent: :destroy

  def active_for_authentication?
    super and !self.erased
  end

  def admin?
    self.admin
  end

  def toggle_admin!
    self.update! admin: !self.admin
  end
end
