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

    def test_render_to_html
      data = {title: 'Slim2pdf', content: 'Slim to PDF conversion gem'}
      template = File.expand_path('../tpl/test.slim', __FILE__)
      writer = Writer.new(template, data)
      html = writer.render_to_html
      assert_match %r(<title>Slim2pdf</title>), html
      assert_match %r(<p>Slim to PDF conversion gem</p>), html
    end

    def test_save_to_html
      data = {title: 'Slim2pdf', content: 'Slim to PDF conversion gem'}
      template = File.expand_path('../tpl/test.slim', __FILE__)
      writer = Writer.new(template, data)
      path = '/tmp/test.html'
      writer.save_to_html(path)
      assert File.exists?(path)
      html = File.read(path)
      assert_match %r(<title>Slim2pdf</title>), html
      assert_match %r(<p>Slim to PDF conversion gem</p>), html
      File.unlink(path)
      assert_equal false, File.exists?(path)
    end
  end
end
