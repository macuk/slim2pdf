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

    private
      # Change hash data to scope object
      def scope
        OpenStruct.new(data)
      end
  end
end
