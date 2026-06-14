require "yaml"
MAX_NUMBER_OF_TRIES = 3

# Main class
class Game
  def initialize
    @choices = [1, 2, 3, 4, 5, 6]
    @colors = { 1 => "verde", 2 => "rosado", 3 => "azul", 4 => "amarillo", 5 => "rojo", 6 => "blanco" }
    @number_of_tries_left = MAX_NUMBER_OF_TRIES
    @try_index = 0
    @has_won = false
  end

  def gen_code
    code = []
    4.times { code.append(@choices.sample) }
    code
  end

  def not_valid?(input)
    return true if input == ""

    variable = interpreta input
    return true if variable.nil?

    false
  end

  def interpreta(input)
    numbers = "1 2 3 4 5 6 7 8 9 0".split
    result = input.split
    return nil if result.any? { |i| true unless numbers.include?(i) }

    result
  end

  def check_input(input)
    if not_valid?(input)
      puts "Input not valid"
      return
    end
    puts "Vale esto si vale"
  end

  def guess
    puts "Intento número #{@try_index + 1}"
    puts "Intenta adivinar, para hacerlo usa estos numeros separados por espacio representando el color"
    puts @colors.to_yaml
    print "Ingresa un código: "
    user_input = gets

    return if not_valid?(user_input)

    # Solo se tomarán cuatro valores
    code_user = user_input.split.map { |a| a.to_i }
    @try_index += 1
    code_user.slice(0, 4)
  end

  def check_guess(code, user_guess)
    puts "Checando si coincide..."
    if code == user_guess
      puts "Ganaste! Lo conseguiste, lo adivinaste!"
      user_wins
      return
    end
    print "Nel, no coinciden peeero... [ "
    print check_if_any_color_is_in_code(code, user_guess).join(" ")
    puts " ]"
  end

  def check_if_any_color_is_in_code(code, user_gess)
    my_arr = []
    my_char = ""
    my_code = code
    user_gess.each_with_index do |c, i|
      if my_code.include?(c)
        my_char = in_right_place?(c, i, my_code) ? "O" : "o"
        my_arr.push my_char
      else
        my_arr.push "."
      end
    end
    my_arr.sort!
  end

  def in_right_place?(c, i, code)
    if code.index(c) == i
      code.replace(code.each_with_index { |x, index| index == i ? "done" : x })
      return true
    end
    false
  end

  def user_wins
    puts "Congratulaciones ganador!"
    @has_won = true
  end

  # main function of the game.
  def start
    puts "Comenzamos..."
    puts "La computadora selecciona un código super secreto..."
    code = gen_code

    loop do
      user_guess = guess
      check_guess(code, user_guess)
      @number_of_tries_left -= 1
      break if @number_of_tries_left < 1 || @has_won
    end

    puts "Lastima... has perdido" unless @has_won

    puts "El codigo secreto"
    code.each { |peg| print "#{@colors[peg]} " }
    puts
    puts "--------------------------"
  end
end
