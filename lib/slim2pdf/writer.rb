module Slim2pdf
  class Writer
    attr_accessor :template, :data
    attr_accessor :wkhtmltopdf_path
    attr_writer :wkhtmltopdf_command
    attr_accessor :footer_text, :footer_font, :footer_font_size
    attr_writer :logger

    def initialize(template = nil, data = {})
      @template = template
      @data = data
      @wkhtmltopdf_path = nil
      @wkhtmltopdf_command = nil
    end

    def render_to_html
      Slim::Template.new(template).render(scope)
    end

    def save_to_html(path)
      create_dir(path)
      File.write(path, render_to_html)
      logger.info "[Slim2pdf] HTML file saved: #{path}" if logger
    end

    def save_to_pdf(path)
      create_dir(path)
      html = create_tmp_html
      full_command = "#{wkhtmltopdf_command} #{html.path} #{path}"
      logger.debug "[Slim2pdf] Run command: #{full_command}" if logger
      `#{full_command}`
      html.unlink
      logger.info "[Slim2pdf] PDF file saved: #{path}" if logger
    end

    # wkhtmltopdf command without html and pdf file params
    def wkhtmltopdf_command
      path = @wkhtmltopdf_path || 'wkhtmltopdf'
      @wkhtmltopdf_command || "#{path} #{footer_params} -q"
    end

    def logger
      @logger ||= defined?(Rails) ? Rails.logger : nil
    end

    private

    # Change hash data to scope object
    def scope
      OpenStruct.new(data)
    end

    # Create dir if not exists
    def create_dir(path)
      FileUtils.mkdir_p(Pathname.new(path).dirname)
    end

    def create_tmp_html
      tmp = Tempfile.new ['slim2pdf', '.html']
      begin
        tmp.write render_to_html
      ensure
        tmp.close
      end
      tmp
    end

    def footer_params
      return unless footer_text
      "--footer-line --footer-font-name '#{footer_font || 'verdana'}' " +
      "--footer-font-size '#{footer_font_size || 10}' --footer-left '#{footer_text}'"
    end
  end
end
