class Part < ActiveRecord::Base
  belongs_to :car

  # Simple "existence" validating, this will satisfy NOT NULL and FOREIGN KEY constraints.
  #
  #   p = Part.new name: "wheel"
  #   p.valid?                         #==> false
  #   p.car = Car.new name: "Toyota"
  #   p.valid?                         #==> true, despite the car instance (p.car) not yet saved.
  #   p.save                           #==> Executes "INSERT INTO cars ... ; INSERT INTO parts ... ".
  #
  # First, insist a car_id is provided...
  validates :car, presence: true

  # ... Second, insist the car is valid. This will cause ActiveRecord to `SELECT cars.* WHERE cars.id = car_id`.
  validates_associated :car
end
