defmodule FuelForOperation do
  @type operation() :: :launch | :land

  @spec calc(number(), number(), operation()) :: integer
  def calc(mass, gravity_acceleration, operation) do
    fuel_for_mass = FuelForMass.calc(mass, gravity_acceleration, operation)
    fuel_for_mass + FuelForMassOfFuel.calc(fuel_for_mass, gravity_acceleration, operation)
  end
end
