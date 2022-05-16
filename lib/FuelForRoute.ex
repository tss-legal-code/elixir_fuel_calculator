defmodule FuelCalculator do
  @moduledoc """
  Documentation for `FuelCalculator`.

  The goal of this main module of the application is to calculate fuel to launch from one planet of the Solar system, and to land on another planet of the Solar system, depending on the flight route.
  """

  defmodule FuelForRoute do
    @type route() :: [[{:launch | :land, number()}]]
    @type mass() :: number()
    @doc """
    Function that calculates mass of the fuel:

    // build project:
    cd ./elixir_fuel_calculator
    iex -S mix

    // enter in REPL these commands:

    FuelCalculator.FuelForRoute.calc(28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]])
    // correct output is: 51898

    FuelCalculator.FuelForRoute.calc(14606, [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]])
    // correct output is: 33388

    FuelCalculator.FuelForRoute.calc(75432, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]])
    // correct output is: 212161

    """
    @spec calc(mass(), route()) :: integer
    def calc(mass, route) do
      internal_calc(mass, Enum.reverse(route), 0)
    end

    defp internal_calc(_mass, [], acc) do
      acc
    end

    defp internal_calc(mass, [head | tail], acc) do
      [operation, gravity_acceleration] = head
      required_fuel = FuelForOperation.calc(mass, gravity_acceleration, operation)

      # IO.puts("part of route [#{to_string(operation)},#{to_string(gravity_acceleration)}], required fuel mass is #{required_fuel} kg")
      internal_calc(mass + required_fuel, tail, acc + required_fuel)
    end
  end
end
