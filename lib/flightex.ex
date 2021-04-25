defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    user_agent = UserAgent.start_link(%{})
    booking_agent = BookingAgent.start_link(%{})
    {user_agent, booking_agent}
  end

  defdelegate get_user(user_id), to: UserAgent, as: :get
  defdelegate create_user(params), to: CreateOrUpdateUser, as: :call

  defdelegate get_booking(booking_id), to: BookingAgent, as: :get
  defdelegate create_booking(params), to: CreateOrUpdateBooking, as: :call
end
