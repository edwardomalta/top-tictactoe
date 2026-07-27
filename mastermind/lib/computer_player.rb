# Jugador "Artificial"
class ComputerPlayer
  attr_accessor :intent_number, :candidates, :code_pos_index

  def initialize(colors, debug: false)
    @colors = colors
    @combinations = gen_combinations(Array.new(4, 0), 0, 6)
    @starting_combitations = [[1, 1, 2, 2], [1, 1, 2, 3], [1, 1, 3, 4]]
    @intent_number = 0
    @debug = debug
    @candidates = @combinations.dup
    @code_pos_index = -1
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

  def get_last_guess
    puts "feedback = #{@feedback}"
    puts "intent_number = #{@intent_number}"
    @feedback[-1][:code].dup
  end

  def get_old_guess
    @feedback[-2][:code].dup
  end

  def pick_next_code
    last_code = get_last_guess
    last_code[@code_pos_index] += last_code[@code_pos_index] < 5 ? -5 : 1
  end

  def think_on_evidence
    # Second attempt or more
    # On 3 attempt we can deduce something
    # COMPARE THIS: cnt. of "o", "O", "." from @feedback[-2][:feedback]
    # agaisnt the same fromm @feedback[-1][:feedback]
    # case 1
    # if all o: all colors in guess are IN secret_code
    # case 2
    # if all .: none of colors in guess are IN secret_code
    # case 3
    # if O +1 fix the new_number in pos -1 pos_index
    # case 4
    # if O -1 fix the last_number in pos -1
    # case 5
    # if o +1 certainty: new_number is in the secret_code
    # case 6
    # if o -1 certainty: last_number is in the secret_code
    # case 7
    # if nothing changes both numbers are not in the code
    # here we switch positions with adjacent (moving what we know is not in the combination).
    # make the same comparison than before but now index is -2
    # old_color = get_old_color
    # last_color = get_last_color
    if @intent_number > 2 # for all the rest of tries there is info to compare
      case compare_feedback
      when 3
        @code_pos_index -= 1
      # new_guess = pick_next_code
      end
    end
    new_guess = pick_next_code
    # Creo que todo está muy bonito pero, aunque sea un minimo metodo de fuerza bruta
    # y probar que las posiciones fijadas sean las que tienen que ser, eso estaría cool.
    # Entonces una forma tonta de hacerlo: correr en bucle hasta encontrar un O.
    return new_guess
  end

  def get_old_color
    old_feedback = get_old_guess
    old_feedback[@code_pos_index]
  end

  def get_last_color
    last_feedback = get_last_guess
    last_feedback[@code_pos_index]
  end

  def compare_feedback
    last_feedback = get_feedback(-1).reduce(Hash.new(0)) do |result, literal|
      result[literal] += 1
      result
    end
    second_to_last_feedback = get_feedback(-2).reduce(Hash.new(0)) do |result, literal|
      result[literal] +=1
      result
    end

    if last_feedback[:O] > second_to_last_feedback[:O]
      return 3
    elsif last_feedback[:O] < second_to_last_feedback[:O]
      return 4
    else
      return -1
    end
  end

  def deduce_method
    # Aqui va a ir el nuevo modelo de deducción
    # Debe retornar una lista de enteros limitada a 1-6
    # Contar los intentos para distinguir el primero.
    # puts "First try detected" if first_try?
    puts "@feedback in try #{@intent_number} is #{@feedback}" if @intent_number >= 1
    code_deduced = first_try? ? gen_code : think_on_evidence
    @intent_number += 1
    return code_deduced
  end

  def feedback(result)
    puts "result = #{result}"
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
