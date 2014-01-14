require 'slim2pdf'

writer = Slim2pdf::Writer.new('doc/examples/simple/template.slim')
writer.save_to_pdf('doc/examples/simple/output.pdf')
