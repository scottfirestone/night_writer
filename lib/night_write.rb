require 'pry'  # => true

class FileReader
  def read
    filename = ARGV[0]   # => nil
    File.read(filename)  # ~> TypeError: no implicit conversion of nil into String
  end
end

class FileWriter

  def write(output)
    filename = ARGV[1]
    File.write(filename, output)
    puts "Created #{filename} containing #{output.length/6} characters."
  end
end

class NightWriter
  attr_reader :reader, :alphabet, :writer

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @alphabet = {"a" => ["0.", "..", ".."], "b" => ["0.", "0.", ".."], "c"=>["00", "..", ".."],
                "d" => ["00", ".0", ".."], "e" => ["0.", ".0", ".."], "f" => ["00", "0.", ".."],
                "g" => ["00", "00", ".."], "h" => ["0.", "00", ".."], "i" => [".0", "0.", ".."],
                "j" => ["0.", "00", ".."], "k" => ["0.", "..", "0."], "l" => ["0.", "0.", "0."],
                "m" => ["00", "..", "0."], "n" => ["00", ".0", "0."], "o" => ["0.", ".0", "0."],
                "p" => ["00", "0.", "0."], "q" => ["00", "00", "0."], "r" => ["0.", "00", "0."],
                "s" => [".0", "0.", "0."], "t" => [".0", "00", "0."], "u" => ["0.", "..", "00"],
                "v" => ["0.", "0.", "00"], "w" => [".0", "00", ".0"], "x" => ["00", "..", "00"],
                "y" => ["00", ".0", "00"], "z" => ["0.", ".0", "00"], "!" => ["..", "00", "0."],
                "'" => ["..", "..", "0."], "," => ["..", "0.", ".."], "-" => ["..", "..", "00"],
                "." => ["..", "00", ".0"], "?" => ["..", "0.", "00"], "#" => [".0", ".0", "00"],
                "0" => [".0", "00", ".."], "1" => ["0.", "..", ".."], "2" => ["0.", "0.", ".."],
                "3" => ["00", "..", ".."], "4" => ["00", ".0", ".."], "5" => ["0.", ".0", ".."],
                "6" => ["00", "0.", ".."], "7" => ["00", "00", ".."], "8" => ["0.", "00", ".."],
                "9" => [".0", "0.", ".."], " " => ["..", "..", ".."], :capitalize =>["..", "..", ".0"]}
  end

  def read_message
    reader.read.chomp.chars
  end

  def encode_to_braille(message)
    top_line = []
    middle_line = []
    bottom_line = []
    message.each do |char|
      if char != " "
        if char.upcase == char
          top_line<<alphabet[:capitalize][0]
        end
      end
      top_line<<alphabet[char.downcase][0]
    end
    message.each do |char|
      if char != " "
        if char.capitalize == char
          middle_line << alphabet[:capitalize][1]
        end
      end
      middle_line<<alphabet[char.downcase][1]
    end
    message.each do |char|
      if char != " "
        if char.capitalize == char
          bottom_line << alphabet[:capitalize][2]
        end
      end
      bottom_line << alphabet[char.downcase][2]
    end

    "#{top_line.join}\n#{middle_line.join}\n#{bottom_line.join}"
  end

  def write_message (message)
    writer.write(message)
  end

end

poop = NightWriter.new
message = poop.read_message
output = poop.encode_to_braille(message)
poop.write_message(output)
