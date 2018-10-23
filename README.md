# Mars Rover

## Installation
- This script uses no dependencies external to Ruby.
- It was written with Ruby 2.5.1
- Use RVM to easily install different Ruby versions if needed: [RVM](https://rvm.io/)

## Usage
Interacting with the mars exploration script is as simple as running the following:
`ruby mars_exploration.rb -icases/example.in -ocases/example.eout`

The script documents it's usage and additional features internally using a `-h` flag.

The `run_tests.rb` script uses the provided cases to ensure that the mars_exploration script is working as expected by testing it's output against a few verified regexes.
`run_test.rb -v` will allow you to see the output of these test cases.

## Implementation Notes
- Realizing the mars rover challenge had no limitations outside of ensuring the rover never leave the plateau defined in the first line of a case, there is no internal map.
  - Instead, all movement is determined using the rover coordinates, and validated against the plateau size which is provided at instantiation.

Assuming you've read through the scripts code:

- You may note `require`'s are littered throughout the `mars_exploration.rb` script rather than placed at the top as one might commonly expect.
  - This is merely for optimizations sake so that in the event that code might not be used due to error, it's not even loaded in.
- The `thor` gem would likely have provided a more user friendly command line interface, but I opted to build it myself as an additional challenge.
- There tends to be a large arguement against global variables, however, making the `permissive` and `verbose` would likely have made sense given their pervasive use in the script.
