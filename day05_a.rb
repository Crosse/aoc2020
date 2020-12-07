#!/usr/bin/env ruby

def binpart(input, min, max)
    output = 0
    input.each_char do |x|
        middle = ((max - min) / 2) + min
        if x == "F" or x == "L" then
            max = middle
        elsif x == "B" or x == "R" then
            min = middle + 1
        end
        #puts "op: %s; min: %3d, max: %3d\n" % [x, min, max]
    end

    if input[-1] == "F" or input[-1] == "L" then output = min end
    if input[-1] == "B" or input[-1] == "R" then output = max end
    return output
end

def calculate_seat(boarding_pass)
    row = binpart(boarding_pass[0..6], 0, 127)
    seat = binpart(boarding_pass[7..10], 0, 7)
    seat_id = (row * 8) + seat

    #puts "#{boarding_pass}: row %3d, seat %d, seat id %4d" % [row, seat, seat_id]
    return seat_id
end

def do_input
    seats = []
    input = File.read("input/day05")
    input.each_line(chomp: true) do |line|
        seats.append(calculate_seat(line))
    end
    seats.sort!
    seats.each_index do |idx|
        next if idx == 0
        if seats[idx] == (seats[idx-1] + 2) then
            puts "seat? #{seats[idx]-1}"
        end
    end
end

do_input
