class Keypad
  attr_reader :code_bank, :code_length

  def initialize(length = 4, mode_keys = "123")
    @key_history = ""
    @code_bank = Hash.new(0)
    @mode_keys = mode_keys
    @code_length = length
    @secret_code = "1337"
    generate_all_codes
  end

  def press
    puts "Please enter a number between 0 and 9"
    print ">"
    input = gets.chomp
    until (0..9).include?(input.to_i)
      puts "Please enter a valid number between 0 and 9"
      print ">"
      input = gets.chomp
    end
    input_code(input)
  end

  def input_code(input)
    @key_history << input
    if (@key_history.length >= @code_length + 1) && @mode_keys.include?(input)
      code = @key_history[(-1 - @code_length)...-1]
      @code_bank[code] += 1
      p "You guessed the secret code" if code == @secret_code
    end
  end

  def run
    until all_codes_entered?
      press
    end
    p "You entered all the codes"
  end

  def generate_all_codes
    all_codes_arr = (0..(10**(@code_length) - 1 )).to_a
    formatted_codes = all_codes_arr.map { |el| el.to_s.rjust(@code_length, "0")}
    formatted_codes.each { |code| @code_bank[code] = 0 }
  end

  def all_codes_entered?
    @code_bank.all? { |key, value| value > 0 }
  end
end
