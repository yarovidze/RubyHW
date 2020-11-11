require_relative 'my_pet'

class Pet
  ACTIONS = { 'give a meal': 1, 'lets play': 2, 'stay at home': 3, 'go to groomer': 4, 'bathing': 5, 'walk on the street': 6, 'lets sleep': 7, 'look at the pet': 8, 'go to veterinarian': 9, 'about pet': 10, exit: 11 }

  def start
    create_pet

    while true
      if (@die == true )
        p 'Your pet has died. Game over'
        break
      end

      action = enter_action
      case action
      when 1
        @pet.eat
      when 2
        @pet.lets_play
      when 3
        @pet.stay_home
      when 4
        @pet.groomer
      when 5
        @pet.bathing
      when 6
        @pet.walk
      when 7
        @pet.lets_sleep
      when 8
        @pet.look
      when 9
        @pet.veterinarian
      when 10
        p @pet
      when 11
        break
      else
        p "entered wrong choice #{action}"
      end
    end
  end

  def create_pet
    puts 'name? '
    name = gets.chomp
    puts 'Choose what pet do you want, cat or dog?'
    animal = gets.chomp
    if animal == 'dog'
      puts 'haffff hafff'
      puts "I'm your new friend. I'm #{animal}, #{name}. What do we do"
      @pet = MyPet.new(name)
    elsif animal == 'cat'
      puts 'myau myau'
      puts "I'm your new friend. I'm #{animal}, #{name}. What do we do"
      @pet = MyPet.new(name)
    else
      puts 'Who are you?'
    end

  end


  def enter_action
    puts 'Pleas choose action : '
    ACTIONS.each_pair {|key, value| puts "#{value}: #{key}" }
    action = gets.to_i
  end

end


Pet.new.start
