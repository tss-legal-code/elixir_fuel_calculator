defmodule FuelForMass do
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

defmodule FuelForOperation do
  def calc(mass, gravity_acceleration, operation) do
    # TODO tests..
    fuel_for_mass = FuelForMass.calc(mass, gravity_acceleration, operation)
    fuel_for_mass + FuelForMassOfFuel.calc(fuel_for_mass, gravity_acceleration, operation)
  end
end

defmodule FuelForRoute do
  # 28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]
  def calc(mass, grav_acc_list) do
    # each calculation must be peformed from the end to the beginning
    internal_calc(mass, Enum.reverse(grav_acc_list), 0)
  end

  defp internal_calc(mass, [], acc) do
    acc
  end

  defp internal_calc(mass, [head | tail], acc) do
    [operation, gravity_acceleration] = head
    required_fuel = FuelForOperation.calc(mass, gravity_acceleration, operation)
    IO.puts("part of route [#{to_string(operation)},#{to_string(gravity_acceleration)}], required fuel mass is #{required_fuel} kg")
    internal_calc(mass + required_fuel, tail,  acc + required_fuel)
  end
end

# was FuelTotal.calc(28801, :earth, :land)

# FuelForOperation.calc(28801, 9.807, :land)
# 13447

# c("d:/do/elixir_fuel_calculator/fuel_calc.exs")
# FuelForRoute.calc(28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]])
