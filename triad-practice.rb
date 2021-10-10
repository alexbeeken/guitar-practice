require 'io/console'

# 3 minutes
TIME_LIMIT = 3 * 60

TRIADS = [
  {
    inversion: "r",
    mode: "M",
    diagram: %{
      e|0|-|-|-|
      B|-|-|0|-|
      G|-|-|0|-|
      D|-|-|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "1",
    mode: "M",
    diagram: %{
      e|0|-|-|-|
      B|0|-|-|-|
      G|-|0|-|-|
      D|-|-|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "2",
    mode: "M",
    diagram: %{           
      e|0|-|-|-|
      B|-|0|-|-|
      G|0|-|-|-|
      D|-|-|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "r",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|0|-|-|-|
      G|-|0|-|-|
      D|-|-|0|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "1",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|-|0|-|-|
      G|0|-|-|-|
      D|-|-|0|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "2",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|0|-|-|-|
      G|0|-|-|-|
      D|0|-|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "r",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|0|-|-|-|
      D|-|-|0|-|
      A|-|-|-|0|
      E|-|-|-|-|
    }
  },
  {
    inversion: "1",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|0|-|-|-|
      D|0|-|-|-|
      A|-|-|0|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "2",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|0|-|-|-|
      D|-|0|-|-|
      A|-|0|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "r",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|-|-|-|-|
      D|0|-|-|-|
      A|-|-|0|-|
      E|-|-|-|0|
    }
  },
  {
    inversion: "1",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|-|-|-|-|
      D|0|-|-|-|
      A|0|-|-|-|
      E|-|-|0|-|
    }
  },
  {
    inversion: "2",
    mode: "M",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|-|-|-|-|
      D|0|-|-|-|
      A|-|0|-|-|
      E|-|0|-|-|
    }
  },
  {
    inversion: "r",
    mode: "m",
    diagram: %{           
      e|0|-|-|-|
      B|-|0|-|-|
      G|-|-|0|-|
      D|-|-|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "1",
    mode: "m",
    diagram: %{           
      e|0|-|-|-|
      B|0|-|-|-|
      G|0|-|-|-|
      D|-|-|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "2",
    mode: "m",
    diagram: %{           
      e|0|-|-|-|
      B|-|-|0|-|
      G|-|0|-|-|
      D|-|-|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "r",
    mode: "m",
    diagram: %{           
      e|-|-|-|-|
      B|0|-|-|-|
      G|0|-|-|-|
      D|-|-|0|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "1",
    mode: "m",
    diagram: %{           
      e|-|-|-|-|
      B|-|0|-|-|
      G|0|-|-|-|
      D|-|0|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "2",
    mode: "m",
    diagram: %{           
      e|-|-|-|-|
      B|0|-|-|-|
      G|-|0|-|-|
      D|-|0|-|-|
      A|-|-|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "r",
    mode: "m",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|0|-|-|-|
      D|-|0|-|-|
      A|-|-|-|0|
      E|-|-|-|-|
    }
  },
  {
    inversion: "1",
    mode: "m",
    diagram: %{
      e|-|-|-|-|
      B|-|-|-|-|
      G|0|-|-|-|
      D|0|-|-|-|
      A|-|0|-|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "2",
    mode: "m",
    diagram: %{
      e|-|-|-|-|
      B|-|-|-|-|
      G|0|-|-|-|
      D|-|-|0|-|
      A|-|-|0|-|
      E|-|-|-|-|
    }
  },
  {
    inversion: "r",
    mode: "m",
    diagram: %{
      e|-|-|-|-|
      B|-|-|-|-|
      G|-|-|-|-|
      D|0|-|-|-|
      A|-|0|-|-|
      E|-|-|-|0|
    }
  },
  {
    inversion: "1",
    mode: "m",
    diagram: %{
      e|-|-|-|-|
      B|-|-|-|-|
      G|-|-|-|-|
      D|0|-|-|-|
      A|0|-|-|-|
      E|-|0|-|-|
    }
  },
  {
    inversion: "2",
    mode: "m",
    diagram: %{           
      e|-|-|-|-|
      B|-|-|-|-|
      G|-|-|-|-|
      D|0|-|-|-|
      A|-|-|0|-|
      E|-|-|0|-|
    }
  }
]

count = 0
correct_count = 0
puts "Press any key to start the quiz, crtl-c to exit"
start_time = Time.now

def retrieve_answers
  puts "inversion?"
  inversion = STDIN.gets.strip
  puts "mode?"
  mode = STDIN.gets.strip

  return [mode, inversion]
end

def ask_random_triad(correct)
  triad = TRIADS.sample

  puts triad[:diagram]
  tries = 0
  answered_correctly = false

  while tries < 3 && !answered_correctly
    answers = retrieve_answers
    mode = answers[0]
    inversion = answers[1]

    if mode == triad[:mode] && inversion == triad[:inversion]
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
    puts "correct mode: #{triad[:mode]}"
    puts "correct inversion: #{triad[:inversion]}"
    puts "take a deep breath and we'll move on in 3 seconds..." 
    sleep 3
  end

  correct
end

char = STDIN.getch

while true do
  elapsed = Time.now - start_time

  if elapsed > TIME_LIMIT
    puts "Time's up! You got #{correct_count} out of #{count} right." 
    exit(1)
  end

  if char
    exit(1) if char == "\u0003"

    correct_count = ask_random_triad(correct_count)
    count += 1
  end
end
