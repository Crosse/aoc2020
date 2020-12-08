#!/usr/bin/env ruby

class Day06
    def doit(input)
        groups = []
        group = nil

        input.each_line(chomp: true) do |line|
            if line.empty? then
                puts "group: #{group}\n\n"
                groups.append group
                group = nil
                next
            end

            puts "person: '#{line}'"
            if group.nil? then
                group = line.chars
            else
                group = group & line.chars
            end
        end

        if !group.empty? then
            puts "group: #{group}\n\n"
            groups.append group
        end

        sum = groups.flatten.length
        puts "#{groups.length} groups, sum: #{sum}"

        return sum
    end
end

if __FILE__ == $0 then
    input = File.read("input/day06")
    problem = Day06.new
    problem.doit(input)
else
    describe Day06 do
        it 'does the neeful' do
            input = <<-EOF.chomp
abc

a
b
c

ab
ac

a
a
a
a

b
EOF
            problem = Day06.new
            sum = problem.doit(input)
            expect(sum).to eq 6
        end
    end
end
