#!/usr/bin/env ruby

require "test/unit"

class Day07Part2
    def initialize(content)
        Bag.reset
        content.each_line(chomp: true) do |line|
            Bag.parse(line)
        end
    end

    def self.from_file(file)
        self.new File.open(file)
    end
end


class Bag
    attr_accessor :descriptor, :bags

    @all_bags = {}

    class << self
        attr_accessor :all_bags
    end

    def initialize(descriptor)
        @descriptor = descriptor
        @bags = {}
    end

    def self.reset
        @all_bags = {}
    end

    def can_eventually_contain?(bag)
        @bags.each do |b, _|
            if b == bag or b.can_eventually_contain?(bag) then
                return true
            end
        end
        return false
    end

    def total_bags
        count = 0
        @bags.each do |b, c|
            count += c + (c * b.total_bags)
        end
        count
    end

    def to_s
        "This #{@descriptor} bag contains #{@bags.keys.count} other bag kinds."
    end

    def ==(other)
        self.descriptor == other.descriptor
    end

    def self.parse(line)
        desc = line[/^(?<desc>.*) bags contain/, "desc"]
        abort if not desc

        bag = @all_bags[desc]
        if not bag then
            bag = Bag.new desc
            @all_bags[bag.descriptor] = bag
        end

        if line =~ /contain no other bags/ then
            return bag
        end

        if bag.bags.keys.count > 0 then
            return bag
        end

        contained = line[/.*contain (?<rest>\d.*)/, "rest"]
        contained.split(/[,.] ?/).each do |part|
            matches = /(?<count>\d+) (?<desc>.*) bags?/.match part
            if not matches then
                puts "failed to match on part: #{part}"
                next
            end

            contained_bag = @all_bags[matches[:desc]]
            if not contained_bag then
                contained_bag = Bag.new(matches[:desc])
                @all_bags[matches[:desc]] = contained_bag
            end

            bag.bags[contained_bag] = matches[:count].to_i
        end

        bag
    end
end


class TestDay07Part2 < Test::Unit::TestCase
    def test_example
        content = <<-EOF.chomp
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
EOF
        Day07Part2.new content
        shiny_gold = Bag.all_bags["shiny gold"]
        assert_equal(shiny_gold.total_bags, 126)
    end

    def test_input
        Bag.all_bags = {}
        Day07Part2.from_file("input/day07")

        shiny_gold = Bag.all_bags["shiny gold"]
        assert_equal(shiny_gold.total_bags, 158493)
    end
end
