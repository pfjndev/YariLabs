class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze
  
  class UnsupportedOperation < StandardError
    def message = "Only '+', '/', '*' operations are permitted."
  end
  
  def self.operation_message(arg1, arg2, arg3)
    case arg3
      when '+' then "#{arg1} #{arg3} #{arg2} = #{arg1 + arg2}"
      when '/' then "#{arg1} #{arg3} #{arg2} = #{arg1 / arg2}"
      when '*' then "#{arg1} #{arg3} #{arg2} = #{arg1 * arg2}"
    end
  end
  
  def self.calculate(first_operand, second_operand, operation)
    begin
      
      raise ArgumentError unless first_operand.is_a?(Integer)
      raise ArgumentError unless second_operand.is_a?(Integer)
      raise UnsupportedOperation.new unless ALLOWED_OPERATIONS.include?(operation)
      raise ZeroDivisionError.new("Division by zero is not allowed.") if second_operand == 0 && operation == "/"
      
      operation_message(first_operand, second_operand, operation)
    rescue ZeroDivisionError => e
      e.message
    end
  end
end