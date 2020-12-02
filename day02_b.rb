valid = 0
input = File.read("input/day02")
input.each_line do |line|
    count, letter, password = line.strip.split
    letter = letter[0]

    x, y = count.split(/-/).map { |x| Integer(x) - 1 }

    if (password[x] == letter) ^ (password[y] == letter) then
        valid+=1
    end
end
puts "Found #{valid} valid passwords."
