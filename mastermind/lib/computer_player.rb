# Jugador "Artificial"
class ComputerPlayer
  def initialize(colors)
    @colors = colors
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
end
