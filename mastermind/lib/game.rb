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

  def not_valid(input)
    false
  end

  def check_input(input)
    return unless not_valid(input)

    puts "Input not valid"
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
