# frozen_string_literal: true


a = 1
b = 2
c = 3

let(:a) { 1 }
let(:b) { 2 }
let(:c) { 3 }

$global = 1

[ [ 1, 2, 3, ], 2, 3, "a", ]

[1, 2, 3]

{
  a: 1,
  b: 2,
}

{
  :a => 1,
  b: 2,
}

def noise(*)
  "hello"
end


noise = 1

puts noise

z =  1
zz = 1

class Sample

end

[1,2,3].each { |n| puts n }

[
]

<<~SQL
  SELECT * from actors
SQL

<<~JAVASCRIPT
  let news = 1
JAVASCRIPT

require 'open3'

class DropToCliToUglify
  def compress(input)
    output = ''

    Open3.popen3('uglifyjs') do |i, o, t|
      i.puts input
      i.close

      while line = o.gets
        output += line
      end
    end

    output
  end
end


@hello
class Hello
  def initialize(first, second, third)
    @first  = first

    @second = second
    @third  = third
    @fourth = fourth
    @fifth = fifth
    @sizh = sizh
  end
end

def hello
  @hello ||= world
end

def self.
config.assets.js_compressor = DropToCliToUglify.new
