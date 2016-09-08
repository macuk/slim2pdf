require 'slim2pdf'

writer = Slim2pdf::Writer.new
writer.template = 'doc/examples/agreement/template.slim'
writer.data = { date: '2014-01-14', part1: 'Google', part2: 'Microsoft' }
writer.footer_text = 'Agreement footer'
writer.save_to_pdf('doc/examples/agreement/output.pdf')
