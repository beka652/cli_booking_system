require "sqlite3"
require_relative "../generator/id_generator"

class User
  @title = "Users"
  @db ||= SQLite3::Database.new "booking_system.db"
  #======== create users table if it doesn't exist
  @db.execute <<~SQL
  CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      role TEXT NOT NULL
  );
  SQL
  #======= create bookings table if it doesn't exist

  def self.get_all_users
    result = @db.execute2 "SELECT * FROM users"
    # continue tmrw from  here
    return {
      title: @title,
      headings: result.delete_at(0),
      rows:result
    }
  end

  def self.create_user name:, role:
    id = IDGenerator.generate_user_id
    result = @db.execute("SELECT * FROM users WHERE id = #{id}")
    until result.empty?
      id = IDGenerator.generate_user_id
      result = @db.execute("SELECT * FROM users WHERE id = #{id}")
    end
    @db.execute("INSERT INTO users (id, name, role) VALUES (#{id} , #{name}, #{role}")

  end

end
