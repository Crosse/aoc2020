#!/usr/bin/env ruby

input = File.read("input/day01")
input.each_line do |x|
    xi = x.to_i
    input.each_line do |y|
        yi = y.to_i
        #puts "x: #{xi}, y: #{yi}, x+y: #{xi+yi}"
        if (xi + yi) == 2020 then
            puts "x=#{xi}, y=#{yi}, x*y=#{xi*yi}"
            exit
        end
    end
end
