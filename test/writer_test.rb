require 'test_helper'

module Slim2pdf
  class WriterTest < MiniTest::Unit::TestCase
    def test_init
      Writer.new
    end

    def test_initialize
      h = {a: 10, b: 20}
      writer = Writer.new('/tmp/tpl.slim', h)
      assert_equal '/tmp/tpl.slim', writer.template
      assert_equal h, writer.data
    end

    def test_accessors
      h = {a: 10, b: 20}
      writer = Writer.new
      writer.template = '/tmp/tpl.slim'
      writer.data = h
      assert_equal '/tmp/tpl.slim', writer.template
      assert_equal h, writer.data
    end
  end
end
