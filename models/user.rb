class User
  attr_accessor :id , :name, :role
  def initialize(id, name, role)
    @id = id
    @name = name
    @role = role
  end
end
