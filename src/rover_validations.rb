module Mars
  module Validations  
    def validate_rover
      validate_plateau
      validate_coordinates
      validate_direction
    end

    def validate_coordinates
      unless @x >= 0 && @x <= @plateau_x && @y >= 0 && @y <= @plateau_y
        errors << "Illegal location passed to rover!, Location = #{@x}:#{@y}" 
        errors << "Please ensure that the rovers initial position is within the specified plateau's space." 
      end
    end

    def validate_direction
      if DIRECTIONS.keys.include? @direction.upcase
        errors << "Illegal direction passed to rover!, Direction = #{@direction}" 
        errors << "Supported directions are: #{DIRECTIONS.keys}"
      end
    end

    def validate_plateau
      unless @plateau_x.class == Integer && @plateau_y.class == Integer
        errors << "Illegal plateau passed to rover!, plateau = #{@plateau_x}:#{@plateau_y}" 
        errors << "Please ensure that the coordinates provided are in whole Integral format"
      end
    end

    def validate_current_position
      unless @x >= 0 && @x <= @plateau_x && @y >= 0 && @y <= @plateau_y
        errors << "Rover attempted to move to an illegal location, Location = #{@x}:#{@y}"
        return false
      end
      true
    end
  end
end
