require 'slim2pdf'

writer = Slim2pdf::Writer.new('doc/examples/invoices/template.slim')
buyers = ['Buyer A', 'Buyer B', 'Buyer C', 'Buyer D']
buyers.each_with_index do |buyer, index|
  number = index + 1
  writer.data = {
    seller: 'Seller', buyer: buyer, number: "#{number}/2014",
    item_name: 'Service', price: '$100', date: '2014-01-14'
  }
  writer.save_to_pdf("doc/examples/invoices/output-#{number}.pdf")
end
