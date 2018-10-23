def validate_output(results, expectation_filepath)
  puts "\nValidating Output -> #{expectation_filepath}\n\n"
  index = 0

  expectations = File.read(expectation_filepath).split("\n").reject(&:empty?)
  while expectations[index] && results[index]
    if expectations[index] != results[index]
      puts "Did not receive expected result of #{expectations[index]} for #{results[index]} at line #{index}"
    else
      puts "#{results[index]} met expectations for line #{index}"
    end
    index += 1
    puts '' if expectations[index] && results[index]
  end
end