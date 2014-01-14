module Slim2pdf
  class Writer
    attr_accessor :template, :data
    attr_accessor :footer_text, :footer_font, :footer_font_size

    def initialize(template=nil, data={})
      @template = template
      @data = data
    end

    def render_to_html
      Slim::Template.new(template).render(scope)
    end

    def save_to_html(path)
      create_dir(path)
      File.write(path, render_to_html)
    end

    def save_to_pdf(path)
      create_dir(path)
      html = create_tmp_html
      `#{wkhtmltopdf_command(html.path, path)}`
      html.unlink
    end

    def wkhtmltopdf_command(html_path, pdf_path)
      "wkhtmltopdf #{footer_params} -q #{html_path} #{pdf_path}"
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
