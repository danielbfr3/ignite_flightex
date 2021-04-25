defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Booking

  def call(%{
        id: id,
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        id_usuario: id_usuario
      }) do
    with true <- UserAgent.is_valid_user(id),
         {:ok, booking} <-
           Booking.build(id, data_completa, cidade_origem, cidade_destino, id_usuario) do
      save_booking({:ok, booking})
    else
      _error -> {:error, "User not found"}
    end
  end

  defp save_booking({:ok, %Booking{id: booking_id} = booking}) do
    BookingAgent.save(booking)
    {:ok, booking_id}
  end
end
