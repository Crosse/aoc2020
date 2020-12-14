#!/usr/bin/env ruby

require "test/unit"

class Day08Part1
    def initialize(content)
        @loader = ConsoleBootLoader.new content
    end

    def run
        @loader.run
    end
end

class Instruction
    attr_reader :isn, :val

    def initialize line
        @isn, val = line.split(/ /)
        @val = val.to_i
        @visited = false
    end

    def visited?
        @visited
    end

    def visit
        @visited = true
    end

    def to_s
        "#{@isn} #{@val}"
    end
end

class ConsoleBootLoader
    attr_accessor :accumulator, :code

    def initialize(code)
        @code = code.map {|line| Instruction.new line}
        @accumulator = 0
        @ip = 0
    end

    def step
        isn = code[@ip]
        if isn.visited? then
            puts "INFINITE LOOP"
            return false
        end
        isn.visit

        puts "%04x: #{isn}" % @ip
        case isn.isn
        when "acc"
            @accumulator += isn.val
            @ip += 1
        when "jmp"
            @ip += isn.val
        when "nop"
            @ip += 1
        end

        return true
    end

    def run
        while @ip < @code.count do
            break unless step
        end
        @accumulator
    end
end

class TestDay08Part1 < Test::Unit::TestCase
    def test_example
        content = <<-EOF.chomp
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
EOF
        day = Day08Part1.new content.lines(chomp: true)
        assert_equal(day.run, 5)
    end

    def test_input
        content = File.read("input/day08")
        day = Day08Part1.new content.lines(chomp: true)
        assert_equal(day.run, 1782)
    end
end
