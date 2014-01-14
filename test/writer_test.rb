require 'test_helper'

module Slim2pdf
  class WriterTest < MiniTest::Unit::TestCase
    def test_init
      Writer.new
    end
  end
end
