defmodule FuelForMassOfFuel do
  # TODO spec for operation
  def calc(mass, gravity_acceleration, operation) do
    internal_calc(mass, gravity_acceleration, operation, 0)
  end

  defp internal_calc(mass, _gravity_acceleration, _operation, extra_fuel) when mass < 0 do
    extra_fuel
  end

  defp internal_calc(mass, gravity_acceleration, operation, extra_fuel) do
    new_mass = FuelForMass.calc(mass, gravity_acceleration, operation)

    adequate_mass =
      case new_mass > 0 do
        true -> new_mass
        _ -> 0
      end

    new_extra_fuel = extra_fuel + adequate_mass
    # TODO test for calculation
    IO.puts("#{to_string(mass)} fuel requires #{to_string(adequate_mass)} more fuel, total more: #{to_string(new_extra_fuel)}")
    internal_calc(new_mass, gravity_acceleration, operation, new_extra_fuel)
  end
end
