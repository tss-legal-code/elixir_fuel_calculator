defmodule FuelForOperation do
  def calc(mass, gravity_acceleration, operation) do
    # TODO tests..
    fuel_for_mass = FuelForMass.calc(mass, gravity_acceleration, operation)
    fuel_for_mass + FuelForMassOfFuel.calc(fuel_for_mass, gravity_acceleration, operation)
  end
end
