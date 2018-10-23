verbose = ARGV.include? '-v'

puts "Use -v flag to see outputs of tests\n\n" unless verbose

def verbose_output(output)
  puts '-'*10
  puts output
  puts '-'*10
  puts ''
end

output = `ruby mars_exploration.rb -icases/example.in -p`
if output.match(/^1 3 N\s*5 1 E$/m)
  print 'PASS' 
else
  print 'FAIL'
end
puts ' => Expect example case to output as per example case provided in challenge'
verbose_output(output) if verbose

output = `ruby mars_exploration.rb -icases/example.in -p -ocases/example.eout`
if output.match(/^1 3 N met expectations for line 0\s*5 1 E met expectations for line 1$/m)
  print 'PASS' 
else
  print 'FAIL'
end
puts ' => Expect example case to succesfully meet the expected output in cases/example.eout'
verbose_output(output) if verbose

output = `ruby mars_exploration.rb -icases/huge.in -p -ocases/huge.eout`
if output.match(/^1 3 N met expectations for line 0\s*5 1 E met expectations for line 1$/m)
  print 'PASS' 
else
  print 'FAIL'
end
puts ' => Expect huge case to succesfully meet the expected output in cases/huge.eout'
verbose_output(output) if verbose

output = `ruby mars_exploration.rb -icases/incorrect.in -p -ocases/incorrect.eout`
if output.match(/Did not receive expected result of 5 5 E for 5 1 E at line 1/m)
  print 'PASS' 
else
  print 'FAIL'
end
puts ' => Expect incorrect case not to meet the expected output in cases/incorrect.eout'
verbose_output(output) if verbose

output = `ruby mars_exploration.rb -icases/illegal.in`
if output.match(/Illegal Rover/m)
  print 'PASS' 
else
  print 'FAIL'
end
puts ' => Expect illegal Case to result in illegal Rover Output'
verbose_output(output) if verbose

output = `ruby mars_exploration.rb -icases/illegal.in -p`
if output.match(/Permissive mode ignored illegal moves:/m)
  print 'PASS' 
else
  print 'FAIL'
end
puts ' => Expect permissive mode to allow output for illegal case'
verbose_output(output) if verbose