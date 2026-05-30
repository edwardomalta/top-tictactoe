# Main class
class Game
  def initialize
    @colors = %i[
      verde rosado azul amarillo rojo blanco
    ]
    @number_of_tries_left = 3
    @try_index = 0
  end

  def gen_code
    code = []
    4.times { code.append(@colors.sample) }
    code
  end

  def not_valid?(input)
    return true if input == ""

    variable = interpreta input
    return true if variable.nil?

    false
  end

  def interpreta(input)
    result = input.split
    return nil if result.any? { |i| i.length > 1 }

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
    return unless @number_of_tries_left.positive?

    puts "Try number #{@try_index + 1}"
    puts "Intenta adivinar:"
    user_input = gets

    check_input(user_input)

    @number_of_tries_left -= 1
    @try_index += 1
  end

  def start
    puts "starting..."

    puts "Creeating code"
    code = gen_code

    guess

    puts code
  end
end
