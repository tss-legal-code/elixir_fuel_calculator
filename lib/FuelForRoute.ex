defmodule FuelCalculator do
  @moduledoc """
  Documentation for `FuelCalculator`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FuelCalculator.hello()
      :world

  """
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

end
