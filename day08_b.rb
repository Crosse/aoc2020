#!/usr/bin/env ruby

require "test/unit"

class Day08Part2
    attr_reader :loader

    def initialize(content)
        @loader = ConsoleBootLoader.new content
    end

    def run
        @loader.run
    end
end

class Instruction
    attr_reader :val
    attr_accessor :isn

    def initialize line
        @isn, val = line.split(/ /)
        @val = val.to_i
        @visited = false
    end

    def visited?
        @visited
    end

    def reset
        @visited = false
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
        reset
    end

    def reset
        puts "resetting VM..."
        @ip = 0
        @accumulator = 0
        code.map {|isn| isn.reset}
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
        reset

        result = false
        while @ip < @code.count do
            result = step
            break unless result
        end
        result
    end

    def swap_isn(isn)
        case isn.isn
        when "nop"
            isn.isn = "jmp"
        when "jmp"
            isn.isn = "nop"
        end
    end

    def fix_corruption
        ptr = 0

        loop do
            puts "modifying location #{ptr}"
            swap_isn @code[ptr]

            break if run == true

            # reset the last instruction to what it was, because clearly that didn't work
            swap_isn @code[ptr]

            next_isn = @code[ptr+1..].index { |isn| ["nop", "jmp"].include? isn.isn }
            ptr += next_isn + 1
            return nil unless ptr
        end
        return ptr
    end
end

class TestDay08Part2 < Test::Unit::TestCase
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
        day = Day08Part2.new content.lines(chomp: true)
        assert_equal(7, day.loader.fix_corruption)
        assert_equal(8, day.loader.accumulator)
    end

    def test_input
        content = File.read("input/day08")
        day = Day08Part2.new content.lines(chomp: true)
        assert_equal(253, day.loader.fix_corruption)
        assert_equal(797, day.loader.accumulator)
    end
end
