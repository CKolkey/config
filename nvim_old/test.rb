# frozen_string_literal: true

class TestClass
  def something
    @here.each { puts something }
    @here.each { puts something }
    @here.each { puts something }
  end
end

a = 1
b = 2
c = 3

let(:a) { 1 }
let(:b) { 2 }
let(:c) { 3 }

$global = 1

def something
  [
    [1, 2, 3],
    [1],
    2,
    3,
    "a"
  ]
end

[]

[1, 2, 3]

{
  a: {
    a: 1,
    b: 2
  },
  b: 2
}

{ :a => [{ "1" => a }, :a, b, c, d], b: 2 }

def noise(aheh, this, that: 1)
  "hello"
end

class NewThing
  def initialize(this, thing: 1, ijjj)

    @this  = this
    @thing = thing
    @ijjj  = ijjj
    @hhhhh = hhhhh
  end
end

def noise(this) = "hello"


def a thing
  if noise.even?
    [1, 2, 3, 4, 5]
  else
    "fish"
  end
end

if noise.even?
  "fish"
else
  "cats"
end

def somethig
  "yes" unless noise.even?
  "yes" if noise.even?
end

nose { |this| "Yes" }

noise == 1
noise > 1
noise <= 1


puts noiseHelp

z =  1
zz = 1

class Sample

end

[1, 2, 3].each { |n| puts n }

[]

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

config.assets.js_compressor = DropToCliToUglify.new
