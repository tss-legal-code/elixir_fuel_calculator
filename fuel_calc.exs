defmodule FuelForMass do
  # gravity is measured in "m/(s^2)"
  @gravity %{:earth => 9.807, :moon => 1.62, :mars => 3.711}

  def calc(mass, planet, operation) do
    apply(FuelForMass, operation, [mass, planet])
  end

  # launching
  def launch(mass, planet) do
    Kernel.trunc(mass * @gravity[planet] * 0.042 - 33)
  end

  # landing
  def land(mass, planet) do
    Kernel.trunc(mass * @gravity[planet] * 0.033 - 42)
  end
end

defmodule FuelForMassOfFuel do
  # TODO spec for operation
  def calc(mass, planet, operation) do
    internal_calc(mass, planet, operation, 0)
  end

  defp internal_calc(mass, planet, operation, extra_fuel) when mass < 0 do
    extra_fuel
  end

  defp internal_calc(mass, planet, operation, extra_fuel) do
    new_mass = FuelForMass.calc(mass, planet, operation)

    adequate_mass =
      case new_mass > 0 do
        true -> new_mass
        _ -> 0
      end

    new_extra_fuel = extra_fuel + adequate_mass
    # TODO test for calculation
    # IO.puts("#{to_string(mass)} fuel requires #{to_string(adequate_mass)} more fuel, total more: #{to_string(new_extra_fuel)}")
    internal_calc(new_mass, planet, operation, new_extra_fuel)
  end
end

defmodule FuelForShip do
  def calc(mass, planet, operation) do
    # TODO tests..
    fuel_for_mass = FuelForMass.calc(mass, planet, operation)
    fuel_for_mass + FuelForMassOfFuel.calc(fuel_for_mass, planet, operation)
  end
end


# FuelTotal.calc(28801, :earth, :land)
