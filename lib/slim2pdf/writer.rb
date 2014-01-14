module Slim2pdf
  class Writer
    attr_accessor :template, :data

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

    private
      # Change hash data to scope object
      def scope
        OpenStruct.new(data)
      end

      # Create dir if not exists
      def create_dir(path)
        FileUtils.mkdir_p(Pathname.new(path).dirname)
      end
  end
end
