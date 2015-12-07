require 'pry'

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
    puts "Created #{filename} containing #{output.length} characters."
  end
end

class NightReader
  attr_reader :chars_array, :reader, :writer, :alphabet, :message, :decoded_array

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @alphabet = {"a" => ["0.","..",".."], "b" => ["0.","0.",".."], "c"=>["00","..",".."], "d" => ["00",".0",".."],
              "e" => ["0.",".0",".."], "f" => ["00","0.",".."], "g" => ["00","00",".."], "h" => ["0.","00",".."],
              "i" => [".0","0.",".."], "j" => ["0.","00",".."], "k" => ["0.","..","0."], "l" => ["0.","0.","0."],
              "m" => ["00","..","0."], "n" => ["00",".0","0."], "o" => ["0.",".0","0."], "p" => ["00","0.","0."],
              "q" => ["00","00","0."], "r" => ["0.","00","0."], "s" => [".0","0.","0."], "t" => [".0","00","0."],
              "u" => ["0.","..","00"], "v" => ["0.","0.","00"], "w" => [".0","00",".0"], "x" => ["00","..","00"],
              "y" => ["00",".0","00"], "z" => ["0.",".0","00"], "!" => ["..","00","0."], "'" => ["..","..","0."],
              "," => ["..","0.",".."], "-" => ["..","..","00"], "." => ["..","00",".0"], "?" => ["..","0.","00"],
              "#" => [".0",".0","00"], " " => ["..", "..", ".."], :capitalize =>["..","..",".0"]}
  end

  def read_message
    @message = reader.read
  end

  def split_content (message)
    new_array = message.split( /\r?\n/ )
    top_line = new_array[0].scan(/../)
    mid_line = new_array[1].scan(/../)
    bot_line = new_array[2].scan(/../)
    @chars_array = top_line.zip(mid_line, bot_line)
  end

  def decode_to_english
    @decoded_array = chars_array.map do |element|
    alphabet.key(element)
    end
  end

  def format(decoded)
    cap_flag = false
    formatted_array = decoded.map do |char|
      if char == :capitalize
        cap_flag = true
      else
        if cap_flag == true
          cap_flag = false
          char.upcase
        else
          char
        end
      end
    end
    formatted_array.delete_if do |element|
      element.class != String
    end
    formatted_array.join
  end

  def write_message (message)
    writer.write(message)
  end
end


poop = NightReader.new
message = poop.read_message
poop.split_content(message)
decoded = poop.decode_to_english
formatted = poop.format(decoded)
poop.write_message(formatted)

# poop.decode_to_english
# poop.decode_to_english(message)
# poop.write_message(output)
