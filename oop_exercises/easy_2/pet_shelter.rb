# Consider the following code. Write the classes and methods that will be necessary to make this code run, and print the following output:

class Pet
  attr_reader :species, :name
  
  def initialize(species, name)
    @species = species
    @name = name
  end

  def to_s
    "- A #{species} named #{name}."
  end
end

class Owner
  attr_reader :name
  
  def initialize(name)
    @name = name
    @pets = []
  end
  
  def add_pet(pet)
    @pets << pet
  end
  
  def number_of_pets
    @pets.size
  end
  
  def print_pets
    puts @pets
  end
end

class Shelter
  def initialize
    @owners = {}
    @@available_pets = []
  end

  def record_pet(pet)
    @@available_pets << pet
  end

  def self.print_pets
    puts @@available_pets
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.print_pets
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('Paul Hanson')
bholmes = Owner.new('Betty Holmes')

shelter = Shelter.new
Shelter.print_pets
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."


# => P Hanson has adopted the following pets:
# => a cat named Butterscotch
# => a cat named Pudding
# => a bearded dragon named Darwin

# => B Holmes has adopted the following pets:
# => a dog named Molly
# => a parakeet named Sweetie Pie
# => a dog named Kennedy
# => a fish named Chester

# => P Hanson has 3 adopted pets.
# => B Holmes has 4 adopted pets.