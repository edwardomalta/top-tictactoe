# Jugador "Artificial"
class ComputerPlayer
  attr_accessor :intent_number

  def initialize(colors)
    @colors = colors
    @combinations = gen_combinations(Array.new(4, 0), 0, 6)
    @starting_combitations = [[1, 1, 2, 2], [1, 1, 2, 3], [1, 1, 3, 4]]
    @intent_number = 0
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

  def first_try?
    @intent_number < 1
  end

  def think_on_evidence
    # TODO implement this
    puts "Aun no implementeado, devolviendo randomm code"
    gen_code
  end

  def deduce_method
    # Aqui va a ir el nuevo modelo de deducción
    # Debe retornar una lista de enteros limitada a 1-6
    # Contar los intentos para distinguir el primero.
    if first_try?
      puts "First try detected"
      starting_code = gen_code
    end
    @intent_number += 1
    code_deduced = first_try? ? starting_code : think_on_evidence
    return code_deduced
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
