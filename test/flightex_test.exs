defmodule FlightexTest do
  use ExUnit.Case

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  describe "create_user/4" do
    setup do
      Flightex.start_agents()

      user_params = %{
        id: 1,
        name: "Daniel Freire",
        email: "daniel@gmail.com",
        cpf: "12312312345"
      }

      response = Flightex.create_user(user_params)

      {:ok, response: response}
    end

    test "when creates a user", %{response: response} do
      assert response ==  {:ok, 1}
    end
  end

  describe "get_user/1" do
    setup do
      Flightex.start_agents()

      user_params = %{
        id: 1,
        name: "Daniel Freire",
        email: "daniel@gmail.com",
        cpf: "12312312345"
      }

      {:ok, user_id} = Flightex.create_user(user_params)

      {:ok, user_id: user_id}
    end

    test "when searches a user", %{user_id: user_id} do
      response = Flightex.get_user(user_id)

      assert response == {
        :ok,
        %User{
          cpf: "12312312345",
          email: "daniel@gmail.com",
          id: 1,
          name: "Daniel Freire"
        }
      }
    end
  end

  describe "create_booking/5" do
    setup do
      Flightex.start_agents()

      user_params = %{
        id: 1,
        name: "Daniel Freire",
        email: "daniel@gmail.com",
        cpf: "12312312345"
      }

      Flightex.create_user(user_params)

      {:ok, full_date} = NaiveDateTime.new(2021, 12, 30, 23, 54, 11)

      booking_params = %{
        id: 1,
        data_completa: full_date,
        cidade_origem: "São Paulo",
        cidade_destino: "Porto Alegre",
        id_usuario: 1
      }

      response = Flightex.create_booking(booking_params)

      {:ok, response: response}
    end

    test "when creates a booking", %{response: response} do
      assert response ==  {:ok, 1}
    end
  end

  describe "get_booking/1" do
    setup do
      Flightex.start_agents()

      user_params = %{
        id: 1,
        name: "Daniel Freire",
        email: "daniel@gmail.com",
        cpf: "12312312345"
      }

      Flightex.create_user(user_params)

      {:ok, full_date} = NaiveDateTime.new(2021, 12, 30, 23, 54, 11)

      booking_params = %{
        id: 1,
        data_completa: full_date,
        cidade_origem: "São Paulo",
        cidade_destino: "Porto Alegre",
        id_usuario: 1
      }

      {:ok, booking_id} = Flightex.create_booking(booking_params)

      {:ok, booking_id: booking_id}
    end

    test "when searches a booking", %{booking_id: booking_id} do
      response = Flightex.get_booking(booking_id)

      assert response == {
        :ok,
        %Booking{
          cidade_destino: "Porto Alegre",
          cidade_origem: "São Paulo",
          data_completa: ~N[2021-12-30 23:54:11],
          id: 1,
          id_usuario: 1
        }
      }
    end
  end

end
