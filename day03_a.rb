#!/usr/bin/env ruby

def trees_hit(xstep, ystep, input)
    x = y = trees = 0

    input.each_index do |idx|
        line = input[idx].strip
        if idx % ystep != 0 or idx < ystep then
            #puts " %03d: #{line}" % idx
            next
        end

        x = (x + xstep) % line.length
        if line[x] == "#" then
            line[x] = "X"
            trees+=1
        else
            line[x] = "O"
        end
        #puts "!%03d: #{line}\t(x = #{x})" % idx
    end
    puts "For (#{xstep}, #{ystep}) you'll hit #{trees} trees"
    return trees
end

input = File.read("input/day03").lines
trees_hit(3, 1, input)
