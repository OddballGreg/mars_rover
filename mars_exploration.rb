if ARGV.count < 1
  puts 'use the -h flag for help'
  exit
end

if ARGV.include? '-h'
  puts 'Example Usage: ruby mars_exploration.rb cases/example.in -p'
  puts 'options:'
  puts '-h => Print this help'
  puts '-i => Input File, Filepath to read instructions from. Expects .in extension'
  puts '-o => Output File, Filepath to read expected output from. Expects .eout extension'
  puts '-p => Permissive Mode, ignore illegal instructions'
  puts '-v => Verbose Mode, verbose printouts of rovers and errors'
  exit
end

args = ARGV
permissive = args.include? '-p'
verbose = args.include? '-v'
filepath = args.select{|arg| arg.start_with?('-i')}.first
expectation_filepath = args.select{|arg| arg.start_with?('-o')}.first

if filepath
  filepath = filepath.gsub('-i', '')
  unless File.exists?(filepath) && filepath.end_with?('.in')
    puts "Invalid Filepath/Filetype provided for #{filepath}" 
    exit
  end
else  
  puts "No input file provided. Please provide an instruction file with the -i flag" 
  exit
end

if expectation_filepath
  expectation_filepath = expectation_filepath.gsub('-o', '')
  unless File.exists?(expectation_filepath) && expectation_filepath.end_with?('.eout')
    puts "Invalid Filepath/Filetype provided #{expectation_filepath}" 
    exit
  end
end

require './src/rover.rb'
require './src/import_instructions.rb'
rovers = import_instructions(filepath, permissive)

require './src/runtime.rb'
results = simulate_results(rovers, verbose, permissive)

if expectation_filepath
  require './src/output_validation.rb'
  validate_output(results, expectation_filepath)
end