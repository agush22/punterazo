class Field < ActiveRecord::Base
  belongs_to :field_type

  attr_accessible :address, :city, :country, :lat, :link, :long, :mail, :name, :neighbourhood, :phone, :state, :street, :usage_id, :field_type_id

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
end
