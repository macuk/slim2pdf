require 'test_helper'

module Slim2pdf
  class WriterTest < MiniTest::Unit::TestCase
    def setup
      @data = {a: 10, b: 20}
    end

    def test_init
      Writer.new
    end

    def test_initialize
      writer = Writer.new('/tmp/tpl.slim', @data)
      assert_equal '/tmp/tpl.slim', writer.template
      assert_equal @data, writer.data
    end

    def test_accessors
      writer = Writer.new
      writer.template = '/tmp/tpl.slim'
      writer.data = @data
      assert_equal '/tmp/tpl.slim', writer.template
      assert_equal @data, writer.data
    end
  end
end
