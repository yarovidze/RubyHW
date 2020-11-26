require_relative 'my_pet'
require_relative 'htmlgen/lib/htmlgen'
require "yaml"

USERDATA = [
    {
        name: "nameadmin",
        pass: "1",
        role: "admin"
    },
    {
        name: "namesadmin",
        pass: "12",
        role: "superadmin"
    }
]

class Pet

  ACTIONS = {'give a meal': 1, 'lets play': 2, 'stay at home': 3, 'go to groomer': 4, 'bathing': 5, 'walk on the street': 6, 'lets sleep': 7, 'look at the pet': 8, 'go to veterinarian': 9, 'about pet': 10, exit: 11,
             'change name':12, 'change type':13, 'reset to default':14, 'kill pet':15,
  }.freeze

  def start
    login
    create_pet
    @pet.save_to_data

    while true
      if @die == true
        p 'Your pet has died. Game over'
        @emoji_status = '&#x2620'
        break
      else
        @emoji_status = '&#x1F60E'
      end

      action = enter_action
      content = "
        <header>
          <h2>Hello!! My name is: #{@name}</h2>
          <h2>I am a #{@pet.animal} #{@emoji}</h2>
        </header>
        <section>
          <h3>This is my characteristics:</h3>
            <ul>
              <li>I am <strong>#{@pet.age}</strong> years old</li>
              <li>Mood level: <strong>#{@pet.mood}</strong></li>
              <li>Health level: <strong>#{@pet.health}</strong></li>
              <li>Clean level is: <strong>#{@pet.clean}</strong></li>
              <li>Sleep level is: <strong>#{@pet.sleep}</strong></li>
              <li>Hair level is: <strong>#{@pet.pet_hair}</strong></li>
              <li>Im hungry on: <strong>#{@pet.hungry}</strong></li>
            </ul>
          <h4>Life status: #{die_status}</h4>
        </section>
      "
      HtmlContent.createHtml(content)
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
      when 12
        @pet.change_name
      when 13
        @pet.change_type
      when 14
        @pet.reset_to_default
      when 15
        @pet.kill
      when 11
        break
      else
        p "entered wrong choice #{action}"
      end
    end
  end

  def login
    puts "Please enter your username and password to start"
    puts "Enter your name:"
    login_name = gets.chomp
    exit if login_name == "exit"
    puts "Enter your password:"
    login_pass = gets.chomp

    user = USERDATA.find { |f| f[:name] == login_name && f[:pass] == login_pass }
    if user.nil?
      @username = "guest"
      @role = "guest"
      puts "Undefined user. Continue as #{@username}"
    else
      @role = user[:role]
      @username = user[:name]
      puts "You logged in as #{@role}"
    end
  end

  def create_pet
    puts 'Give your pet a name: '
    @name = gets.chomp
    puts 'Choose what pet do you want, cat or dog?'
    animal = gets.chomp.downcase
    if animal == 'dog'
      puts 'haffff hafff'
      puts "I'm your new friend. I'm #{animal}, #{@name}. What do we do"
      @emoji = '&#x1F415'
      @pet = MyPet.new(@name, animal, @role, @username)
    elsif animal == 'cat'
      puts 'myau myau'
      puts "I'm your new friend. I'm #{animal}, #{@name}. What do we do"
      @pet = MyPet.new(@name, animal, @role, @username)
      @emoji = '&#x1F63A'
    else
      puts 'Who are you?'
    end

  end

  def  die_status
    if @die == true
      p 'Your pet has died. Game over'
      @emoji_status = '&#x2620'
    else
      @emoji_status = '&#x1F60E'
    end
  end


  def enter_action
    puts 'Pleas choose action : '
    ACTIONS.each_pair { |key, value| puts "#{value}: #{key}" }
    action = gets.to_i
  end

end


Pet.new.start
