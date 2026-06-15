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
    @user_role = ""
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

  def check_guess(user_guess)
    puts "Checando si coincide..."
    if @code == user_guess
      puts "Ganaste! Lo conseguiste, lo adivinaste!"
      user_wins
      return
    end
    print "Nel, no coinciden peeero... [ "
    print check_if_any_color_is_in_code(user_guess).join(" ")
    puts " ]"
  end

  def check_if_any_color_is_in_code(user_gess)
    my_arr = []
    my_char = ""
    my_code = @code
    puts "DEBUG:"
    p user_gess
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

  def set_user_role
    print "Elije: a) Crear código; b) Adivinar: "
    respuesta = gets
    @user_role = respuesta == "a\n" ? "coder" : "broker"
  end

  def user_guesser?
    set_user_role if @user_role == ""
    @user_role == "broker"
  end

  def computer_code
    puts "La computadora ha seleccionado un código super secreto..."
    gen_code
  end

  def user_code
    puts @colors.to_yaml
    print "Selecciona un codigo de cuatro colores: "
    result = gets
    result.split.map { |x| x.to_i }
  end

  def guess_cycle
    loop do
      player_guess = user_guesser? ? guess : computer_guesser_v1
      check_guess(player_guess)
      @number_of_tries_left -= 1
      break if @number_of_tries_left < 1 || @has_won
    end
  end

  # May be this is going to be in other class:
  def computer_guesser_v1
    # gen_code.map { |x| x.to_s }
    gen_code
  end

  # main function of the game.
  def start
    puts "Comenzamos..."
    @code = user_guesser? ? computer_code : user_code

    guess_cycle

    puts "Lastima... has perdido" unless @has_won

    puts "El codigo secreto"
    @code.each { |peg| print "#{@colors[peg]} " }
    puts
    puts "--------------------------"
  end
end
