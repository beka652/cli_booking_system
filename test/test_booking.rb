require "minitest/autorun"
require "sqlite3"

require_relative "../generator/id_generator"
require_relative "../models/user"
require_relative "../models/resource"
require_relative "../models/booking"

class TestBooking < Minitest::Test
  DB_PATH = File.expand_path("../db/booking_system.db", __dir__)

  def setup
    @db = SQLite3::Database.new(DB_PATH)
    clear_tables
    seed_user_and_resource
  end

  def teardown
    @db.close if @db
  end

  def test_make_booking_creates_booking_for_available_resource
    made = Booking.make_booking(@user_id, @resource_id, "2026-04-10", "2026-04-12")

    assert_equal true, made

    rows = @db.execute("SELECT user_id, resource_id, status FROM bookings")
    assert_equal 1, rows.length
    assert_equal [@user_id, @resource_id, "ACTIVE"], rows.first
  end

  def test_make_booking_rejects_conflicting_booking
    Booking.make_booking(@user_id, @resource_id, "2026-04-10", "2026-04-12")

    made = Booking.make_booking(@user_id, @resource_id, "2026-04-11", "2026-04-13")

    assert_equal false, made
    assert_equal 1, @db.execute("SELECT * FROM bookings").length
  end

  def test_booking_exist_returns_true_for_saved_booking
    Booking.make_booking(@user_id, @resource_id, "2026-04-10", "2026-04-12")
    booking_id = @db.execute("SELECT id FROM bookings").dig(0, 0)

    assert_equal true, Booking.booking_exist?(booking_id)
  end

  def test_cancel_booking_marks_booking_cancelled
    Booking.make_booking(@user_id, @resource_id, "2026-04-10", "2026-04-12")
    booking_id = @db.execute("SELECT id FROM bookings").dig(0, 0)

    cancelled = Booking.cancel_booking(booking_id)
    status = @db.execute("SELECT status FROM bookings WHERE id = ?", [booking_id]).dig(0, 0)

    assert_equal true, cancelled
    assert_equal "CANCELLED", status
  end

  def test_cancel_booking_returns_false_if_already_cancelled
    Booking.make_booking(@user_id, @resource_id, "2026-04-10", "2026-04-12")
    booking_id = @db.execute("SELECT id FROM bookings").dig(0, 0)
    Booking.cancel_booking(booking_id)

    cancelled_again = Booking.cancel_booking(booking_id)

    assert_equal false, cancelled_again
  end

  private

  def clear_tables
    @db.execute("DELETE FROM bookings")
    @db.execute("DELETE FROM users")
    @db.execute("DELETE FROM resources")
  end

  def seed_user_and_resource
    User.create_user(name: "Test User", role: "member")
    Resource.add_resource(name: "Meeting Room", category: "room")

    @user_id = @db.execute("SELECT id FROM users").dig(0, 0)
    @resource_id = @db.execute("SELECT id FROM resources").dig(0, 0)
  end
end
