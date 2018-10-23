def simulate_results(rovers, verbose, permissive)
  results = []

  rovers.each.with_index do |rover, index|
    if verbose
      puts "Rover #{index + 1}"
      puts '--------------------------'
      if rover.illegal?
        puts "Rover is illegal! Reasons:"
        rover.errors.each do |error|
          puts error
        end
      else
        rover.perform_instruction_set!
        if rover.errors.any?
          if permissive
            puts 'Permissive Mode ignored illegal rover moves:'
            puts "#{rover.x} #{rover.y} #{rover.direction}" 
            results << "#{rover.x} #{rover.y} #{rover.direction}"
          else
            puts "Rover made illegal moves:"
            rover.errors.each do |error|
              puts "\t" + error
            end
          end
        else
          puts "#{rover.x} #{rover.y} #{rover.direction}"
          results << "#{rover.x} #{rover.y} #{rover.direction}"
        end
      end
      puts '--------------------------'
      puts ''
    else
      if rover.illegal?
        puts 'Illegal Rover'
      else
        rover.perform_instruction_set!
        if rover.illegal? && !permissive
          puts 'Illegal Rover'
        else
          puts 'Permissive mode ignored illegal moves:' if rover.illegal?
          puts "#{rover.x} #{rover.y} #{rover.direction}"
          results << "#{rover.x} #{rover.y} #{rover.direction}"
        end
      end
      puts '' unless rovers.last == rover
    end
  end

  results
end