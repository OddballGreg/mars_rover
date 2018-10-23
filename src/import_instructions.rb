def import_instructions(filepath, permissive)
  read_rover_previously = false
  plateau = {}
  rovers = []

  File.read(filepath).split("\n").each.with_index do |line, index|
    if index == 0
      if line.match(/^\d+ \d+$/)
        info = line.split(' ')
        plateau = {x: info[0], y: info[1]}
      else
        puts "Invalid Instructions on line #{index} #{line}: Please provide a platuau setup in format \'(integer) (integer)\' on first instruction line"
        exit
      end
    elsif index.odd?
      next
    elsif read_rover_previously
      if line.match(/^\w+$/)
        rovers.last.register_instruction_set(line)
        read_rover_previously = false
      else
        puts "Invalid Instructions on line #{index} #{line}: Every odd instruction line after the first should be a description of at least one required move for the preceding rover: 'MMMLRM'"
        exit
      end
    else
      if line.match(/^\d+ \d+ \w$/)
        info = line.split(' ')
        rovers << Mars::Rover.new({x: info[0].to_i, y: info[1].to_i, direction: info[2], plateau_x: plateau[:x].to_i, plateau_y: plateau[:y].to_i, permissive: permissive})
        read_rover_previously = true
      else
        puts "Invalid Instructions on line #{index} #{line}: Every second instruction line should be a description of a rovers position and direction: '(x) (y) (direction)'"
        exit
      end
    end
  end

  rovers
end