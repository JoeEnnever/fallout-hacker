def solve()
  words = File.read(ARGV[0]).split("\n")
  similarities = {}
  words.each do |word|
    similarities[word] = {}
    other_words = words - [word]
    other_words.each do |other|
      similarities[word][other] = similarity(word, other)
    end
  end
  loop do
    guess = top_similarity(similarities)
    puts guess
    similarity = STDIN.readline.chomp
    similarity = Integer(similarity)
    similarities.delete(guess)
    if similarity > 0
      similarities.each do |word, similarities_by_word|
        if similarities_by_word[guess] != similarity
          similarities.delete(word)
        end
      end
    end
  end
end

def top_similarity(similarities)
  similarities.max_by do |word, similarities_by_word|
    score = 0
    similarities_by_word.each do |_word, similarity|
      score += 1 if similarity > 0
    end
    score
  end.first
end

def similarity(word, other)
  similarity = 0
  word.each_char.each_with_index do |char, i|
    similarity += 1 if other[i] == char
  end
  similarity
end

if $0 == __FILE__
  solve()
end
