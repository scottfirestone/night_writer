require 'minitest/autorun'
require 'night_write'

class NightWriterTest < Minitest::Test

  def test_a_to_braille
    x = NightWriter.new
    y = x.encode_to_braille("a")
    assert_equal ["0.", "..", ".."], y
  end

  def test_multiple_chars
    skip
    x = NightWriter.new
    # x.encode_to_braille("ab")
    assert_equal [["0.", "..", ".."], ["0.", "0.", ".."]], x.encode_to_braille("ab")
  end

  def test_capitalization
    skip
  end

  def test_braille_output
    skip
  end

  def test_braille_to_english
    skip
  end

end

# class FailingTest < Minitest::Test
#   def test_fails
#     assert_equal 1, 2
#   end
#
#   def test_skips
#     skip
#     assert_equal 1, 1
#   end
#
#   def test_error
#     iouoiure
#   end
# end
