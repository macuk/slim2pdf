require 'test_helper'
require 'logger'
require 'stringio'

module Slim2pdf
  class WriterTest < MiniTest::Unit::TestCase
    def setup
      @data = { title: 'Slim2pdf', content: 'Slim to PDF conversion gem' }
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
      assert_match %r{<title>Slim2pdf</title>}, html
      assert_match %r{<p>Slim to PDF conversion gem</p>}, html
    end

    def test_save_to_html
      path = '/tmp/test.html'
      @writer.save_to_html(path)
      assert File.exist?(path)
      html = File.read(path)
      assert_match %r{<title>Slim2pdf</title>}, html
      assert_match %r{<p>Slim to PDF conversion gem</p>}, html
      File.unlink(path)
      assert_equal false, File.exist?(path)
    end

    def test_save_to_html_with_dir_creation
      path = '/tmp/a/b/c/test.html'
      @writer.save_to_html(path)
      html = File.read(path)
      assert_match(/<html>/, html)
      FileUtils.rm_rf('/tmp/a')
      assert_equal false, File.exist?('/tmp/a')
    end

    def test_save_to_pdf
      path = '/tmp/test.pdf'
      @writer.save_to_pdf(path)
      assert File.exist?(path)
      File.unlink(path)
      assert_equal false, File.exist?(path)
    end

    def test_wkhtmltopdf_path
      assert_equal 'wkhtmltopdf  -q', @writer.wkhtmltopdf_command
      @writer.wkhtmltopdf_path = '/test/path/to/wkhtmltopdf'
      assert_equal '/test/path/to/wkhtmltopdf  -q', @writer.wkhtmltopdf_command
    end

    def test_wkhtmltopdf_command
      assert_equal 'wkhtmltopdf  -q', @writer.wkhtmltopdf_command
      @writer.wkhtmltopdf_command = 'test -a -b -c'
      assert_equal 'test -a -b -c', @writer.wkhtmltopdf_command
    end

    def test_footer_params
      @writer.footer_text = 'Footer'
      command = @writer.wkhtmltopdf_command
      assert_match(/Footer/, command)
      assert_match(/10/, command)
      assert_match(/verdana/, command)
      @writer.footer_font = 'arial'
      @writer.footer_font_size = 14
      command = @writer.wkhtmltopdf_command
      assert_match(/14/, command)
      assert_match(/arial/, command)
    end

    def test_logger_accessor
      assert_nil @writer.logger
      stderr = Logger.new(STDERR)
      @writer.logger = stderr
      assert_equal stderr, @writer.logger
    end

    def test_logging
      sio = StringIO.new
      @writer.logger = Logger.new(sio)
      @writer.logger.level = Logger::DEBUG
      @writer.save_to_html('/tmp/out.html')
      File.unlink('/tmp/out.html')
      @writer.save_to_pdf('/tmp/out.pdf')
      File.unlink('/tmp/out.pdf')
      log = sio.string
      assert_match %r{/tmp/out.html}, log
      assert_match %r{/tmp/out.pdf}, log
      assert_match(/Run command: wkhtmltopdf/, log)
    end
  end
end
