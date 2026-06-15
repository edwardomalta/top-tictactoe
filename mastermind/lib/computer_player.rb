# Jugador "Artificial"
class ComputerPlayer
  def initialize(colors)
    @colors = colors
    @combinations = gen_combinations(Array.new(4, 0), 0, 6)
  end

  def gen_code
    code = []
    4.times { code.append(@colors.keys.sample) }
    code
  end

  def feedback(array)
    puts array
    puts "mames que voy a hacer con esta data?"
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
