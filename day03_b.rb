#!/usr/bin/env ruby

def trees_hit(xstep, ystep, input)
    x = trees = 0

    input.each_index do |idx|
        line = input[idx].strip
        next if idx % ystep != 0 or idx < ystep

        x = (x + xstep) % line.length
        if line[x] == "#" then
            trees+=1
        end
    end
    return trees
end

input = File.read("input/day03").lines

slopes = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2]
]

acc = 1
slopes.each do |xstep, ystep|
    trees = trees_hit(xstep, ystep, input)
    acc *= trees
    puts "For (#{xstep}, #{ystep}) you'll hit #{trees} trees"
end

puts "Final answer: #{acc}"
