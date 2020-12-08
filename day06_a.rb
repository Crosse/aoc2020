#!/usr/bin/env ruby

input = File.read("input/day06")

groups = []

group = []
input.each_line(chomp: true) do |line|
    if line.empty? then
        #puts "group: #{group}"
        groups.append group
        group = []
        next
    end
    #puts "person: #{line}"
    group = group.union line.chars
end

if !group.empty? then
    groups.append group
end

sum = groups.flatten.length
puts "#{groups.length} groups, sum: #{sum}"
