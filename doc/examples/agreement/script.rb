require 'slim2pdf'

w = Slim2pdf::Writer.new
w.template = 'doc/examples/agreement/template.slim'
w.data = {date: '2014-01-14', part1: 'Google', part2: 'Microsoft'}
w.footer_text = 'Agreement footer'
w.save_to_pdf('doc/examples/agreement/output.pdf')
