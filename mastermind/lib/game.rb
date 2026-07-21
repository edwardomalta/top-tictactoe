require "yaml"
require_relative "computer_player"
MAX_NUMBER_OF_TRIES = 15

# Main class
class Game
  def initialize(debug: false)
    @debug = debug
    @choices = [1, 2, 3, 4, 5, 6]
    @colors = { 1 => "verde", 2 => "rosado", 3 => "azul", 4 => "amarillo", 5 => "rojo", 6 => "blanco" }
    @number_of_tries_left = MAX_NUMBER_OF_TRIES
    @try_index = 0
    @has_won = false
    @user_role = ""
    @computer_player = ComputerPlayer.new(@colors)
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
      message = user_guesser? ? "Ganaste! hurray!" : "Haz perdido! La computadora lo adivino!"
      puts message
      if user_guesser?
        user_wins
      else
        computer_wins
      end
      return
    end
    feedback = get_feedback(user_guess)
    print "Nel, no coinciden peeero... [ "
    print feedback.join(" ")
    puts " ]"

    @computer_player.feedback({ feedback: feedback.dup, code: user_guess.dup }) unless user_guesser?
  end

  # The rule says:
  # After the codebreaker makes a guess, the code maker checks their code and places key pegs.
  # A white peg means 1 guessed peg is the correct color, but is in the wrong position.
  # A red peg means 1 guessed peg is the correct color and in the correct position.
  # No peg means that a guessed peg is not a part of the code.
  # Here I use "." for empty, "o" for correct color but wrong place, and "O" for correct color and place.
  def get_feedback(user_guess)
    my_arr = []
    my_char = ""
    user_guess.each_with_index do |color, index|
      if @code.include?(color)
        my_char = @code[index] == color ? "O" : "o"
        my_arr.push my_char
      else
        my_arr.push "."
      end
    end
    my_arr.sort!
  end

  def user_wins
    puts "Congratulaciones ganador!"
    @has_won = true
  end

  def computer_wins
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
    @computer_player.gen_code
  end

  def debug_code
    @computer_player.gen_code
  end

  def user_code
    # Esto de abajo parece que no será necesario por ahora
    # puts @colors.to_yaml if @try_index == MAX_NUMBER_OF_TRIES
    print "Selecciona un codigo de cuatro colores: "
    result = gets
    result.split.map(&:to_i)
  end

  def guess_cycle
    loop do
      player_guess = user_guesser? ? guess : computer_guesser_v1
      check_guess(player_guess)
      @number_of_tries_left -= 1
      break if @number_of_tries_left < 1 || @has_won
    end
  end

  def guess_cycle_debug
    loop do
      player_guess = computer_guesser_v1 # obtenemos el dato generado por esta cosita
      check_guess(player_guess)
      @number_of_tries_left -= 1
      break if @number_of_tries_left < 1 || @has_won
    end
  end

  # May be this is going to be in other class:
  def computer_guesser_v1
    # gen_code.map { |x| x.to_s }
    @computer_player.pensar if @debug
    @computer_player.deduce_code
  end

  # main function of the game.
  def start
    if @debug
      puts "tamos probando"
      # Generamos un codigo
      debug_code
      guess_cycle_debug
    else
      puts "Comenzamos..."
      @code = user_guesser? ? computer_code : user_code
      guess_cycle
    end

    if user_guesser?
      puts "Lastima... has perdido" unless @has_won
    else
      puts "Ganaste! la computadora no pudo adivinar!" unless @has_won
    end

    if @code
      puts "El codigo secreto"
      @code.each { |peg| print "#{@colors[peg]} " }
      puts
      puts "--------------------------"
    else
      puts "No hay nimaiz"
    end
  end
end
