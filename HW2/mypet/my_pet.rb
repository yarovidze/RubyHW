class MyPet
  attr_accessor :name
  def initialize(name)
    @name = name
    @healthy_level = 10
    @mood_level = 5
    @hungry_level = 2
    @sleep_level = 5
    @clean_level = 5
    @pet_hair_level = 0
    @toilet_status = false
    @time = 0
  end

  def eat
    if (@hungry_level < 10)
      puts 'WAUUUU. Thank you my friend '
      @mood_level = @mood_level + rand(2)
      @hungry_level = @hungry_level + rand(5)
      @pet_hair_level = @pet_hair_level + rand(5)
      @clean_level = @clean_level - rand(2)
      @toilet_status = true
    else
      puts "Stop!!! I do not want to eat"
    end
    years_old
  end

  def lets_play
    if (@mood_level >= 5)
      p 'rrrrrrrrrr give me your slippers'
      @mood_level = @mood_level + rand(3)
      @hungry_level = @hungry_level - rand(3)
      @sleep_level = @sleep_level - rand(5)
      @clean_level = @clean_level - rand(2)
    else
      puts 'I want stay alone'
    end
    years_old
  end

  def stay_home
    @healthy_level = @healthy_level - rand(3)
    @mood_level = @mood_level - rand(3)
    @sleep_level = 5
    @clean_level = @clean_level - rand(3)
    @pet_hair_level = @pet_hair_level + rand(2)
    p "I don't want to look at you all day"
    @toilet_status = false
    years_old
  end

  def groomer
    if (@pet_hair_level < 5)
      p 'Nooooooooo just not that'
      @healthy_level = @healthy_level - rand(5)
      @mood_level = @mood_level - rand(5)
      @hungry_level = @hungry_level - rand(5)
      @sleep_level = @sleep_level - rand(3)
      @clean_level = 10
      @pet_hair_level = 10
    else
      p 'Boss I look amazing'
    end
    years_old
  end

  def bathing
    if (@clean_level <= 5)
      p 'I hate youuuuuuuu!!!!!!!'
      @mood_level = @mood_level - rand(4)
      @hungry_level = @hungry_level - rand(4)
      @clean_level = 5
    else
      p 'Nonono. Im cleaner than you'
    end
    years_old
  end

  def walk
    if (@sleep_level >= 5)
      p 'Eeeeeehhhaaaaa!!! where do we go this time?'
      @healthy_level = @healthy_level - rand(3)
      @mood_level = @mood_level + rand(4)
      @hungry_level = @hungry_level - rand(3)
      @sleep_level = @sleep_level - rand(3)
      @clean_level = @clean_level - rand(3)
      @toilet_status = false
    else
      p "Noooo please. I want sleep "
    end
    years_old
  end

  def lets_sleep
    if (@sleep_level < 5)
      puts 'zzzzzzzzzzzzzzzzzzz'
      @sleep_level = 10
      @healthy_level = 10
      @mood_level = @mood_level + rand(4)
      @hungry_level = @hungry_level - rand(3)
      @clean_level = @clean_level - rand(3)
    else
      puts 'noooo. I want play'
    end
    years_old
  end

  def look
    behavior = ['play toys', 'sleep', 'take socks', 'eat']
    p behavior.sample
    years_old
  end

  def veterinarian
    if (@healthy_level < 5)
      p 'I fell bad'
      @healthy_level = 10
      @mood_level = @mood_level - rand(5)
    else
      p 'Nooooo I feel good'
    end
    years_old
  end

  def die
    if (@healthy_level <= 0 || @hungry_level <= 0)
      @die = true
    else
      @die = false
    end
  end


  private

  def years_old
    @time = @time + rand(3)
    @age = (@time / 12).to_i
  end


end