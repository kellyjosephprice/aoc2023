#!/usr/bin/env ruby

part2 = ARGV[0] === '2'
filename = ARGV[1] || './input'

strings = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9",
}

sum = File.open(filename).readlines.reduce(0) do |sum, line|
  if part2
    regex = /\d|#{strings.keys.join('|')}/
    first = line.match(regex)
    last = line.slice(line.rindex(regex), line.length).match(regex)
    next sum if !first

    mapper = ->(token) { strings.has_key?(token) ? strings[token] : token }
    sum + (mapper.(first[0]) + mapper.(last[0])).to_i
  else
    match = line.scan(/\d/)
    next sum if !match

    sum + (match.first + match.last).to_i
  end
end

puts sum
