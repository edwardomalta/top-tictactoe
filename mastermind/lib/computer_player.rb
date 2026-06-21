# Jugador "Artificial"
class ComputerPlayer
  def initialize(colors)
    @colors = colors
    @combinations = gen_combinations(Array.new(4, 0), 0, 6)
    @starting_combitations = [[1, 1, 2, 2], [1, 1, 2, 3], [1, 1, 3, 4]]
  end

  def gen_code
    code = []
    4.times { code.append(@colors.keys.sample) }
    code
  end

  def deduce_code
    result = []
    if @last_feedback
      puts "Si hay last..."
      result = @starting_combitations.sample
    else
      puts "no no hay...."
      result = @starting_combitations.sample
    end
    result
  end

  def feedback(result)
    # No se si quiero esto
    @last_feedback ||= []
    @last_feedback.append(result)
    puts "mames que voy a hacer con esta data?"
    p @last_feedback
  end

  def gen_combinations(current, position, max)
    return [current.dup] if position == current.length

    result = []
    (1..max).each do |value|
      current[position] = value
      result += gen_combinations(current, position + 1, max)
    end
    result
  end

  def pensar
    puts "Pensamiento tengo #{@combinations.length} combinaciones posibles... ¿cómo reduzco el problema?"
  end
end
