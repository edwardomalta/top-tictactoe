# Jugador "Artificial"
class ComputerPlayer
  attr_accessor :intent_number, :candidates

  def initialize(colors, debug: false)
    @colors = colors
    @combinations = gen_combinations(Array.new(4, 0), 0, 6)
    @starting_combitations = [[1, 1, 2, 2], [1, 1, 2, 3], [1, 1, 3, 4]]
    @intent_number = 0
    @debug = debug
    @candidates = @combinations.dup
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

  def get_last_feedback
    @feedback[-1][:feedback].dup
  end

  def get_last_code_used
    @feedback[-1][:code].dup
  end

  def think_on_evidence
    # Second attempt or more
    new_guess = get_last_code_used
    new_guess[-1] += new_guess[-1] < 5 ? -5 : 1
    # On 3 attempt we can deduce something
    # COMPARE THIS: cnt. of "o", "O", "." from @feedback[-2][:feedback]
    # agaisnt the same fromm @feedback[-1][:feedback]
    # if O +1 fix the new_number in pos -1
    # if O -1 fix the last_number in pos -1
    # if o +1 certainty: new_number is in the secret_code
    # if o -1 certainty: last_number is in the secret_code
    # if nothing changes both numbers are not in the code
    # here we switch positions with adjacent (moving what we know is not in the combination).
    # make the same comparison than before but now index is -2
    return new_guess
  end

  def deduce_method
    # Aqui va a ir el nuevo modelo de deducción
    # Debe retornar una lista de enteros limitada a 1-6
    # Contar los intentos para distinguir el primero.
    # puts "First try detected" if first_try?
    code_deduced = first_try? ? gen_code : think_on_evidence
    @intent_number += 1
    return code_deduced
  end

  def feedback(result)
    @feedback ||= []
    @feedback.append(result)
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
