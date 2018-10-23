require './src/rover_validations.rb'

module Mars
  DIRECTIONS = {N: 0, E: 90, S: 180, W: 270}

  class Rover
    include Validations
    attr_accessor :x, :y, :direction, :plateau_x, :plateau_y, :permissive
    attr_reader :errors, :error, :instructions

    def initialize(options)
      @errors = []
      @error = false

      options.each do |key, value|
        send("#{key}=", value) unless respond_to?("@#{key}=")
      end

      validate_rover
    end

    def register_instruction_set(instructions)
      unless instructions.class == String
        @errors << 'Instructions are not a valid string format'
      end

      @instructions = instructions
    end

    def illegal?
      @errors.any?
    end

    def perform_instruction_set!
      throw "Illegal Rover Cannot Be Instructed" if @errors.any?

      instructions.chars.each.with_index do |instruction, index|
        perform_instruction(instruction)
        if @permissive && @error
          @errors << 'Ignoring Illegal Move: #{index} #{instruction}'
        elsif @error
          @errors << "Ceasing Instructions Due To Illegal Move: #{index} #{instruction}"
          return self
        end
      end

      self
    end

    private

    def perform_instruction(instruction)
      instruction = instruction.upcase
      case instruction
      when 'L'
        rotate_left
      when 'R'
        rotate_right
      when 'M'
        move_forward
      else
        @errors << "Illegal instruction passed to rover!, Instruction = #{instruction}"
        @error = true
      end
    end

    def rotate_left
      new_direction = (DIRECTIONS[@direction.upcase.to_sym] - 90)
      if new_direction.negative?
        new_direction = 360 + new_direction
      end
      @direction = DIRECTIONS.invert[new_direction]
    end

    def rotate_right
      new_direction = (DIRECTIONS[@direction.upcase.to_sym] + 90) % 360
      @direction = DIRECTIONS.invert[new_direction]
    end

    def move_forward
      case @direction.upcase.to_sym
      when :N
        @y = @y + 1
        unless validate_current_position
          @y = @y - 1
        end
      when :E
        @x = @x + 1
        unless validate_current_position
          @x = @x - 1
        end
      when :W
        @x = @x - 1
        unless validate_current_position
          @x = @x + 1
        end
      when :S
        @y = @y - 1
        unless validate_current_position
          @y = @y + 1
        end
      else
        throw "Cannot move using illegal direction!, Direction = #{@direction}"
      end
    end
  end
end