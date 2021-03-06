#!/usr/bin/env ruby

valid = 0
input = File.read("input/day02")
input.each_line(chomp: true) do |line|
    count, letter, password = line.split
    letter = letter[0]

    min, max = count.split(/-/).map { |x| Integer(x) }

    val = password.split(//).count { |x| x == letter }
    if val >= min and val <= max then
        valid+=1
    end
end
puts "Found #{valid} valid passwords."
