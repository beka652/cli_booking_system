require "sqlite3"

class Resource
  @title = "Resources"
  @db ||= SQLite3::Database.new "booking_system.db"

  @db.execute <<~SQL
  CREATE TABLE IF NOT EXISTS resources (
      id TEXT  PRIMARY KEY,
      name TEXT NOT NULL,
      category TEXT NOT NULL
  );
  SQL


  def self.resource_exist? (resouce_id)
    result = @db.execute("SELECT * FROM resources WHERE id = '#{resouce_id}'")
    if result.empty?
      return false
    else
      return true
    end

  end

  def self.get_all_resources
    result = @db.execute2 ("SELECT * FROM resources")
    return {
      title: @title,
      headings: result.delete_at(0),
      rows: result
    }
  end

  def self.add_resource name:, category:
    id = IDGenerator.generate_resource_id
    result = @db.execute("SELECT * FROM resources WHERE id = '#{id}'")
    until result.empty?
      id = IDGenerator.generate_resource_id
      result = @db.execute("SELECT * FROM resources WHERE id ='#{id}'")
    end
    @db.execute("INSERT INTO resources (id, name, category) VALUES (?, ?, ?)",
      [id, name, category])

  end
end
