module Slim2pdf
  class Writer
    attr_accessor :template, :data

    def initialize(template=nil, data={})
      @template = template
      @data = data
    end
  end
end
