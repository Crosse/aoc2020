#!/usr/bin/env ruby

class Bag
    attr_accessor :descriptor, :bags

    @all_bags = {}

    class << self
        attr_accessor :all_bags
    end

    def initialize(descriptor)
        @descriptor = descriptor
        @bags = []
    end

    def can_eventually_contain?(bag)
        @bags.each do |b|
            if b == bag or b.can_eventually_contain?(bag) then
                return true
            end
        end
        return false
    end

    def to_s
        "This #{@descriptor} bag contains #{@bags.count} other bag kinds."
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

        if bag.bags.count > 0 then
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

            bag.bags << contained_bag
        end

        bag
    end
end

input = File.open("input/day07")
input.each_line(chomp: true) do |line|
    #puts "Parsing: #{line}"
    Bag.parse(line)
end

shiny_gold = Bag.all_bags["shiny gold"]

#test = Bag.all_bags["shiny purple"]
#puts test.can_eventually_contain?(shiny_gold)

bags = Bag.all_bags.values.filter {|bag| bag.can_eventually_contain?(shiny_gold)}
puts bags.count
