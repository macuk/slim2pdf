require 'test_helper'

module Slim2pdf
  class WriterTest < MiniTest::Unit::TestCase
    def setup
      @data = {title: 'Slim2pdf', content: 'Slim to PDF conversion gem'}
      @template = File.expand_path('../tpl/test.slim', __FILE__)
      @writer = Writer.new(@template, @data)
    end

    def test_init
      Writer.new
    end

    def test_initialize
      assert_equal @template, @writer.template
      assert_equal @data, @writer.data
    end

    def test_accessors
      writer = Writer.new
      writer.template = @template
      writer.data = @data
      assert_equal @template, writer.template
      assert_equal @data, writer.data
    end

    def test_render_to_html
      html = @writer.render_to_html
      assert_match %r(<title>Slim2pdf</title>), html
      assert_match %r(<p>Slim to PDF conversion gem</p>), html
    end

    def test_save_to_html
      path = '/tmp/test.html'
      @writer.save_to_html(path)
      assert File.exists?(path)
      html = File.read(path)
      assert_match %r(<title>Slim2pdf</title>), html
      assert_match %r(<p>Slim to PDF conversion gem</p>), html
      File.unlink(path)
      assert_equal false, File.exists?(path)
    end

    def test_save_to_html_with_dir_creation
      path = '/tmp/a/b/c/test.html'
      @writer.save_to_html(path)
      html = File.read(path)
      assert_match %r(<html>), html
      FileUtils.rm_rf('/tmp/a')
      assert_equal false, File.exists?('/tmp/a')
    end

    def test_save_to_pdf
      path = '/tmp/test.pdf'
      @writer.save_to_pdf(path)
      assert File.exists?(path)
      File.unlink(path)
      assert_equal false, File.exists?(path)
    end
  end
end
