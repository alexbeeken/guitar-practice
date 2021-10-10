require 'io/console'

# 3 minutes
TIME_LIMIT = 3 * 60

ALL_THREE_STRING_GROUPS = [
  "GBE", "DGB", "ADG", "EAD"
]
ALL_TRIAD_INVERSIONS = [
  "root",
  "first",
  "second",
]
ALL_MODES = [
  "major",
  "dorian",
  "phrygian",
  "lydian",
  "mixolydian",
  "minor",
  "locrian"
]
ALL_KEYS = [
  "A",
  "A#/Bb",
  "B",
  "C",
  "C#/Db",
  "D",
  "D#/Eb",
  "E",
  "F",
  "F#/Gb",
  "G",
  "G#/Ab",
]

SCALES = [
  {
    play_a: "pentatonic scale",
    in_position: [
      1, 2, 3, 5, 6
    ],
    in_key: ALL_KEYS,
  },
  {
    play_a: "diatonic scale",
    in_position: [
      1, 2, 3, 4, 5, 6, 7
    ],
    in_key: ALL_KEYS,
    # too advanced!
    # in_mode: ALL_MODES,
  }
]

TRIADS = [
  {
    play_a: "triad",
    root: ALL_KEYS,
    in_mode: ["major", "minor"],
    in_inversion: ALL_TRIAD_INVERSIONS,
    on_strings: ALL_THREE_STRING_GROUPS
  }
]

ALL_EXERCIZES = [SCALES, TRIADS].flatten

def find(value)
  if value.is_a? Array
    puts value.sample
  else
    puts value
  end
end

def randomize_exercize(exercize)
  exercize.each do |key, value|
    print key
    print " "
    print find value
    print " "
  end
end

count = 0
puts "Press any key to generate a new exercize, crtl-c to exit"
start_time = Time.now

while true do
  char = STDIN.getch
  elapsed = Time.now - start_time

  if elapsed > TIME_LIMIT
    puts "Time's up! You did #{count} exercizes."
    exit(1)
  end

  if char
    exit(1) if char == "\u0003"

    count += 1
    print "exercize #{count}: " 
    randomize_exercize(ALL_EXERCIZES.sample)
    print "\n" 
  end
end
