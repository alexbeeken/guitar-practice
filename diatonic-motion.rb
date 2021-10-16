require 'io/console'

TIME_LIMIT = 60

CYCLE_5 = [
  {
    movement: [4,1],
    effect: "resolution"
  },
  {
    movement: [1,5],
    effect: "progression"
  },
  {
    movement: [5,2],
    effect: "retrogression"
  },
  {
    movement: [2,6],
    effect: "resolution"
  },
  {
    movement: [6,3],
    effect: "prolongation"
  },
  {
    movement: [7,3],
    effect: "weak"
  },
  {
    movement: [3,6],
    effect: "prolongation"
  },
  {
    movement: [6,2],
    effect: "progression"
  },
  {
    movement: [2,5],
    effect: "progression"
  },
  {
    movement: [5,1],
    effect: "resolution"
  },
  {
    movement: [1,4],
    effect: "progression"
  },
]
CYCLE_3 = [
  {
    movement: [1,6],
    effect: "prolongation"
  },
  {
    movement: [6,4],
    effect: "progression"
  },
  {
    movement: [4,2],
    effect: "prolongation"
  },
  {
    movement: [2,7],
    effect: "weak"
  },
  {
    movement: [7,5],
    effect: "weak"
  },
  {
    movement: [5,3],
    effect: "resolution"
  },
  {
    movement: [3,1],
    effect: "retreat to tonic"
  },
  {
    movement: [1,3],
    effect: "prolongation"
  },
  {
    movement: [3,5],
    effect: "weak"
  },
  {
    movement: [5,7],
    effect: "weak"
  },
  {
    movement: [7,2],
    effect: "weak"
  },
  {
    movement: [2,4],
    effect: "prolongation"
  },
  {
    movement: [4,6],
    effect: "weak"
  },
  {
    movement: [6,1],
    effect: "retreat"
  }
]
CYCLE_2 = [
  {
    movement: [1,2],
    effect: "progression"
  },
  {
    movement: [2,3],
    effect: "partial resolution"
  },
  {
    movement: [3,4],
    effect: "progression"
  },
  {
    movement: [4,5],
    effect: "progression"
  },
  {
    movement: [5,6],
    effect: "resolution"
  },
  {
    movement: [6,7],
    effect: "weak"
  },
  {
    movement: [7,1],
    effect: "weak"
  },
  {
    movement: [2,1],
    effect: "resolution"
  },
  {
    movement: [3,2],
    effect: "progression"
  },
  {
    movement: [4,3],
    effect: "partial resolution"
  },
  {
    movement: [5,4],
    effect: "retrogression"
  },
  {
    movement: [6,5],
    effect: "progression"
  },
  {
    movement: [7,6],
    effect: "weak"
  },
  {
    movement: [1,7],
    effect: "weak"
  }
]

CYCLES = [
  CYCLE_2,
  CYCLE_3,
  CYCLE_5,
].flatten

DIATONIC_CHORDS = [
  {
    name: "IMaj7",
    degree: 1,
    function: "tonic",
    stability: "most stable"
  },
  {
    name: "II-7",
    degree: 2,
    function: "subdominant",
    stability: "less stable"
  },
  {
    name: "III-7",
    degree: 3,
    function: "tonic",
    stability: "stable"
  },
  {
    name: "IVMaj7",
    degree: 4,
    function: "subdominant",
    stability: "unstable"
  },
  {
    name: "V7",
    degree: 5,
    function: "dominant",
    stability: "very unstable"
  },
  {
    name: "VI-7",
    degree: 6,
    function: "tonic",
    stability: "relatively stable"
  },
  {
    name: "VII-7 b5",
    degree: 7,
    function: "none",
    stability: "weak"
  }
]

count = 0
correct = 0
puts "Press any key to start the quiz, crtl-c to exit"
start_time = Time.now

def retrieve_answer
  puts "what is the diatonic musical effect in the progression?"
  return STDIN.gets.strip
end

def calculate_answer(chord1, chord2)
  degree1 = chord1[:degree]
  degree2 = chord2[:degree]

  answer = CYCLES.detect do |cycle|
    cycle[:movement] == [degree1, degree2]
  end

  return nil if answer.nil?
  return answer[:effect]
end

def format_question(chord1, chord2)
  puts "motion from: #{chord1[:name]} to #{chord2[:name]}"
end

def ask_random(correct)
  chords = DIATONIC_CHORDS.sample(2)
  correct_answer = calculate_answer(chords.first, chords.last)

  while correct_answer == nil
    chords = DIATONIC_CHORDS.sample(2)
    correct_answer = calculate_answer(chords.first, chords.last)
  end

  format_question(chords.first, chords.last)
  tries = 0
  answered_correctly = false

  while tries < 3 && !answered_correctly
    answer = retrieve_answer

    if answer == correct_answer
      puts "correct!"
      answered_correctly = true
      correct += 1
    else
      tries += 1
      puts "incorrect"
    end
  end

  if !answered_correctly
    puts "OUCH!!"
    puts "correct answer: #{correct}"
    puts "take a deep breath and we'll move on in 3 seconds..." 
    sleep 3
  end

  correct
end

char = STDIN.getch

while true do
  elapsed = Time.now - start_time

  if elapsed > TIME_LIMIT
    puts "Time's up! You got #{correct} out of #{count} right." 
    exit(1)
  end

  if char
    exit(1) if char == "\u0003"

    correct = ask_random(correct)
    count += 1
  end
end
