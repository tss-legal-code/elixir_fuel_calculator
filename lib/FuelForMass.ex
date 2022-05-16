defmodule FuelForMass do
  @type operation() :: :launch | :land

  @spec calc(number(), number(), operation()) :: integer
  def calc(mass, gravity_acceleration, operation) do
    apply(FuelForMass, operation, [mass, gravity_acceleration])
  end

  def launch(mass, gravity_acceleration) do
    Kernel.trunc(mass * gravity_acceleration * 0.042 - 33)
  end

  def land(mass, gravity_acceleration) do
    Kernel.trunc(mass * gravity_acceleration * 0.033 - 42)
  end
end
