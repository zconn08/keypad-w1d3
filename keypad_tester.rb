require_relative 'keypad'

class KeypadTester
  def initialize(length,mode_keys)
    @keypad = Keypad.new(length,mode_keys)
    @code_counter = 0
    @press_counter = 0
  end

  def run
    @keypad.code_bank.each do |code, entries|
      digits = code.split("") << "1"
      if entries == 0
        digits.each do |digit|
          @keypad.input_code(digit)
          @press_counter += 1
        end
      end
    end

    code_counter_check

    # #for testing purposes
    # p @keypad.code_bank
    # p @code_counter
    # p @press_counter
    # p duplicate_counter
    # p @keypad.all_codes_entered?
  end

  def code_counter_check
    @keypad.code_bank.each do |key,val|
      @code_counter += val
    end
  end

  def duplicate_counter
    @code_counter - 10**(@keypad.code_length)
  end
end


KeypadTester.new(4,"123").run
