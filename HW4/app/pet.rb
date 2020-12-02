require "erb"
require "rack"

class Pet
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @healthy_level = 10
    @mood_level = 10
    @hungry_level = 3
    @sleep_level = 5
    @clean_level = 5
    @pet_hair_level = 0
  end

  def response
    case @request.path
    when "/"
      Rack::Response.new(render("welcome.html.erb"))
    when "/welcome"
      Rack::Response.new do |response|
        response.set_cookie("pet_name", @request.params["pet_name"].capitalize)
        response.set_cookie("healthy_level", @healthy_level)
        response.set_cookie("mood_level", @mood_level)
        response.set_cookie("hungry_level", @hungry_level)
        response.set_cookie("sleep_level", @sleep_level)
        response.set_cookie("clean_level", @clean_level)
        response.set_cookie("pet_hair_level", @pet_hair_level)
        response.set_cookie("pre_text", "Hello my friend")
        response.redirect("/start")
      end
    when "/start"
      Rack::Response.new(render("index.html.erb"))
    when "/action"
      return eat if @request.params["eat"]
      return play if @request.params["play"]
      return stay_home if @request.params["stay_home"]
      return groomer if @request.params["groomer"]
    end

  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def get(attr)
    @request.cookies[attr]
  end

  def eat
    if @hungry_level <= 5
      @mood_level += rand(2)
      @hungry_level += rand(5)
      @pet_hair_level += rand(5)
      @clean_level -= rand(2)

      Rack::Response.new do |response|
        response.set_cookie("pre_text", "WAUUUU. Thank you my owner")
        response.set_cookie("mood_level", @mood_level)
        response.set_cookie("hungry_level", @hungry_level)
        response.set_cookie("sleep_level", @sleep_level)
        response.set_cookie("clean_level", @clean_level)
        response.redirect("/start")
      end
    else
      Rack::Response.new do |response|
        response.set_cookie("pre_text", "Stop!!! I do not want to eat")
        response.redirect("/start")
      end
    end
  end

  def play
    if @mood_level >= 5
      @mood_level += rand(3)
      @hungry_level -= rand(3)
      @sleep_level -= rand(5)
      @clean_level -= rand(2)

      Rack::Response.new do |response|
        response.set_cookie("pre_text", "rrrrrrrrrr give me your slippers")
        response.set_cookie("mood_level", @mood_level)
        response.set_cookie("hungry_level", @hungry_level)
        response.set_cookie("sleep_level", @sleep_level)
        response.set_cookie("clean_level", @clean_level)
        response.redirect("/start")
      end
    else
      Rack::Response.new do |response|
        response.set_cookie("pre_text", "I want stay alone")
        response.redirect("/start")
      end
    end
  end

  def stay_home
    @healthy_level -= rand(1..3)
    @mood_level -= rand(1..3)
    @sleep_level = 5
    @clean_level -= rand(1..3)
    @pet_hair_level += rand(2..5)
    Rack::Response.new do |response|
      response.set_cookie("pre_text", "I don't want to look at you all day")
      response.set_cookie("healthy_level", @healthy_level)
      response.set_cookie("mood_level", @mood_level)
      response.set_cookie("sleep_level", @sleep_level)
      response.set_cookie("clean_level", @clean_level)
      response.set_cookie("pet_hair_level", @pet_hair_level)
      response.redirect("/start")
    end
  end

  def groomer
    if @pet_hair_level < 5
      @healthy_level -= rand(5)
      @mood_level -= rand(5)
      @hungry_level -= rand(5)
      @sleep_level -= rand(3)
      @clean_level = 10
      @pet_hair_level = 10
      Rack::Response.new do |response|
        response.set_cookie("pre_text", "Nooooooooo just not that")
        response.set_cookie("healthy_level", @healthy_level)
        response.set_cookie("mood_level", @mood_level)
        response.set_cookie("hungry_level", @hungry_level)
        response.set_cookie("sleep_level", @sleep_level)
        response.set_cookie("clean_level", @clean_level)
        response.set_cookie("pet_hair_level", @pet_hair_level)
        response.redirect("/start")
      end
    else
      Rack::Response.new do |response|
        response.set_cookie("pre_text", "Boss I look amazing")
        response.redirect("/start")
      end
    end
  end


end