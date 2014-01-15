# Slim2pdf [![Code Climate](https://codeclimate.com/github/macuk/slim2pdf.png)](https://codeclimate.com/github/macuk/slim2pdf)

Slim2pdf renders slim template with data hash and saves the results as pdf file.

## Installation

Add this line to your application's Gemfile:

    gem 'slim2pdf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slim2pdf

## Usage

    require 'slim2pdf'

### Create writer object

    writer = Slim2pdf::Writer.new
    writer.template = 'path/to/template.slim'
    writer.data = {key1: value1, key2: value2}

### Set parameters in initializer

    writer = Slim2pdf::Writer.new('tpl.slim', {key1: 'a', key2: 'b'})

### Possible actions

    writer.render_to_html # return rendered html as string

    writer.save_to_html(html_path) # saves rendered html to file

    writer.save_to_pdf(pdf_path) # saves rendered html as pdf file

## Examples

### Change slim template to pdf file (doc/examples/simple/).

    require 'slim2pdf'

    writer = Slim2pdf::Writer.new('doc/examples/simple/template.slim')
    writer.save_to_pdf('doc/examples/simple/output.pdf')

### Generate agreement (doc/examples/agreement/).

    require 'slim2pdf'

    w = Slim2pdf::Writer.new
    w.template = 'doc/examples/agreement/template.slim'
    w.data = {date: '2014-01-14', part1: 'Google', part2: 'Microsoft'}
    w.footer_text = 'Agreement footer'
    w.save_to_pdf('doc/examples/agreement/output.pdf')

### Generate bulk invoices (doc/examples/invoices/).

    require 'slim2pdf'

    w = Slim2pdf::Writer.new('doc/examples/invoices/template.slim')
    buyers = ['Buyer A', 'Buyer B', 'Buyer C', 'Buyer D']
    buyers.each_with_index do |buyer, index|
      number = index + 1
      w.data = {
        seller: 'Seller', buyer: buyer, number: "#{number}/2014",
        item_name: 'Service', price: '$100', date: '2014-01-14'
      }
      w.save_to_pdf("doc/examples/invoices/output-#{number}.pdf")
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
