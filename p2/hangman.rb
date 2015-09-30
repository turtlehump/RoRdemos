#!/usr/bin/env ruby
#ectra credit implemented

def valid(guess)
  if(guess.length() != 1)
    puts("guess not the corret length.")
    return false
  end
  if(guess =~ /[a-z]/)
    return true
  end
  puts("guess wasnt a-z.")
  return false
end



word_length_check = false
begin
  print "Enter word length between 5-20: "
  word_length = gets.chomp #returns a string
  word_length_check = (word_length.to_i.to_s == word_length) #if word_length is NOT an int, the to_i function will make it 0. the to_s will take the variable back to itself if it was an int. 0 is also an invalid word length so it works out
  if(!word_length_check)
    puts "invalid word length"
  end
end while (!word_length_check) #we have a valid int



word_length = word_length.to_i #word_length is now an int
if (word_length > 20)
  word_length = 20
  puts "Your word length has been changed to 20"
elsif (word_length < 5)
  word_length = 5
  puts "Your word length has been changed to 5"
end



num_guesses = 10
winner = false
dictionary = `cat words.txt`.split(/\n/).keep_if { |x| x if x.length() == word_length }
prev_guesses = Array.new()
word_picked = false
the_word = ""
the_word_ary = Array.new(word_length, nil)

begin
  while(num_guesses > 0)
    #puts "The dictionary is " + dictionary.length().to_s() + " words long"
    old_dictionary = Array.new(dictionary)
    correct_guess = false
    begin

      begin
        puts "You have " + num_guesses.to_s() + " guesses left"
        print "Previous guesses: "
        prev_guesses.each { |x| print "#{x} "}
        print "\n"
        print "enter your guess: "
        guess = gets.strip()
      end while(!valid(guess)) #will break out when we have a valid guess

      guessed_before = false
      prev_guesses.each { |x| guessed_before = true if(guess == x) }
      if(guessed_before)
        puts ""
        puts "You already guessed " + guess 
        puts ""
      end

    end while (guessed_before)
    prev_guesses.push(guess)

    if(!word_picked)
      dictionary.keep_if { |x| !( x.to_s.match(/#{guess}/) ) } #this line does everything basically
      if(dictionary.length() == 0)
        rand_num_gen = Random.new
        dictionary = Array.new(old_dictionary)
        the_word = dictionary[rand_num_gen.rand(dictionary.length())] # <- thats the extra credit line
        word_picked = true
        correct_guess = true
        for i in 0..the_word.length()
          the_word_ary[i] = the_word[i]
        end
      end
    else
      if(the_word.match(/#{guess}/))
        correct_guess = true
      end
    end

    if(!word_picked)
      puts ""
      puts "_ " * word_length
      puts ""
    else
      puts ""
      none_missing = true
      the_word_ary.each { |x| 
                          should_print = false
                          for i in 0..prev_guesses.length()
                            if(x == prev_guesses[i])
                              should_print = true
                            end
                          end
                          if(should_print)
                            print "#{x} "
                          else
                            print "_ "
                            none_missing = false #if this is never called then none_missing will stay true and u won
                          end
                        }
      if(none_missing)
        winner = true
      end
      puts ""
      puts ""
    end

    if(!correct_guess)
      num_guesses -= 1
    end
  end
end while (!winner && num_guesses > 0)

if(winner)
  puts "WINNER!!! YOU ROCK!!!"
else
  puts ""
  puts "YOU LOSE!"
  puts "The word was: " + the_word
end
