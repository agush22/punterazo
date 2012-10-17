class Field < ActiveRecord::Base
  belongs_to :field_type
  belongs_to :user

  attr_accessible :address, :city, :country, :lat, :link, :long, :mail, :name, :neighbourhood, :phone, :state, :street, :usage, :field_type_id
  validates :name, :presence => true
  validates :lat, :long, :numericality => true, :allow_nil => true
  validates :phone, :numericality => true, :allow_blank => true
  USAGE = %w{Ligas Renta}

  scope :newest, order("updated_at DESC")
  scope :accepted, where(:status => :accepted)
  scope :rejected, where(:status => :rejected)
  scope :pending, where(:status => :pending)

  state_machine :status, :initial => :pending do
    state :pending
    state :accepted
    state :rejected

    event :accept do
      transition [:pending] => :accepted
    end

    event :reject do
      transition [:pending] => :rejected
    end

    event :reset do
      transition any => :pending
    end
  end

  def self.map_info_to_json
    self.all.to_json(:only => [:id, :name, :lat, :long])
  end
end
