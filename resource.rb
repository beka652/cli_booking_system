class Resource
  # Data class for representing each individual resource
  attr_accessor :id , :name, :category
  def intialize(id, name , category)
    @id = id
    @name = name
    @category = category
  end
end
