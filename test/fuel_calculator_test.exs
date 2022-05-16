defmodule FuelCalculatorTest do
  use ExUnit.Case
  doctest FuelCalculator

  test "Find amount of fuel for the ship itself: Apollo 11 Command and Service Module, with a weight of 28801 kg, to land it
  on the Earth" do
    assert FuelForMass.calc(28801, 9.807, :land) === 9278
  end

  test "Fuel adds weight to the ship, so it requires additional fuel, until additional fuel is 0 or negative" do
    assert FuelForMassOfFuel.calc(9278, 9.807, :land) === 4169
  end

  test "Apollo 11:
  path: launch Earth, land Moon, launch Moon, land Earth;
  weight of equipment: 28801 kg;
  weight of fuel: 51898 kg" do
    assert FuelCalculator.FuelForRoute.calc(28801, [
             [:launch, 9.807],
             [:land, 1.62],
             [:launch, 1.62],
             [:land, 9.807]
           ]) === 51898
  end

  test "Mission on Mars:
  path: launch Earth, land Mars, launch Mars, land Earth;
  weight of equipment: 14606 kg;
  weight of fuel: 33388 kg" do
    assert FuelCalculator.FuelForRoute.calc(14606, [
             [:launch, 9.807],
             [:land, 3.711],
             [:launch, 3.711],
             [:land, 9.807]
           ]) === 33388
  end

  test "Passenger ship:
  npath: launch Earth, land Moon, launch Moon, land Mars, launch Mars, land Earth;
  weight of equipment: 75432 kg;
  weight of fuel: 212161 kg" do
    assert FuelCalculator.FuelForRoute.calc(75432, [
             [:launch, 9.807],
             [:land, 1.62],
             [:launch, 1.62],
             [:land, 3.711],
             [:launch, 3.711],
             [:land, 9.807]
           ]) === 212_161
  end
end
