#!/usr/bin/env ruby

input = File.read("input/day01")
input.each_line do |x|
    xi = x.to_i
    input.each_line do |y|
        yi = y.to_i
        input.each_line do |z|
            zi = z.to_i
            if (xi + yi + zi) == 2020 then
                puts "x=#{xi}, y=#{yi}, z=#{zi}, x*y*z=#{xi*yi*zi}"
                exit
            end
        end
    end
end
