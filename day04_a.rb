#!/usr/bin/env ruby

class Passport
    def initialize(byr, iyr, eyr, hgt, hcl, ecl, pid, cid)
        @birth_year = byr
        @issue_year = iyr
        @expiration_year = eyr
        @height = hgt
        @hair_color = hcl
        @eye_color = ecl
        @passport_id = pid
        @country_id = cid
    end

    def to_s
        fmt = "{byr => %s, iyr => %s, eyr => %s, hgt => %s, hcl => %s, ecl => %s, pid => %s, cid => %s}"
        fmt % [
            @birth_year,
            @issue_year,
            @expiration_year,
            @height,
            @hair_color,
            @eye_color,
            @passport_id,
            @country_id
        ]
    end

    def is_valid
        valid = !(@birth_year.nil? or
                 @issue_year.nil? or
                 @expiration_year.nil? or
                 @height.nil? or
                 @hair_color.nil? or
                 @eye_color.nil? or
                 @passport_id.nil?)
        puts "invalid: #{self}" if not valid
        return valid
    end

    def self.from_line(line)
        data = Hash.new
        line.split(/ /).each do |atom|
            k, v = atom.split(/:/)
            data[k] = v
        end
        return self.new(
                   data["byr"],
                   data["iyr"],
                   data["eyr"],
                   data["hgt"],
                   data["hcl"],
                   data["ecl"],
                   data["pid"],
                   data["cid"]
               )
    end
end

input = File.open("input/day04")

passports = []
record = []
input.each_line(chomp:true) do |line|
    if line.empty? then
        p = Passport.from_line(record.join(" "))
        #puts p
        passports.append p

        record = []
        next
    end
    record.append line
end

if !record.empty? then
    p = Passport.from_line(record.join(" "))
    passports.append p
end

valid = passports.filter {|p| p.is_valid}.count
puts "Found #{passports.count} passports, of which #{valid} are valid"
