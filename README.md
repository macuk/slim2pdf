# Slim2pdf [![Code Climate](https://codeclimate.com/github/macuk/slim2pdf.png)](https://codeclimate.com/github/macuk/slim2pdf)

Slim2pdf renders [slim template](http://slim-lang.com/) with data hash and saves the results as pdf file.

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
    writer.template = 'template.slim'
    writer.data = {name: 'John', surname: 'Doe'}

### Set parameters in initializer

    writer = Slim2pdf::Writer.new('template.slim', {name: 'John', surname: 'Doe'})

### Possible actions

    writer.render_to_html # return rendered html as string

    writer.save_to_html('output.html') # saves rendered html to file

    writer.save_to_pdf('output.pdf') # saves rendered html as pdf file

### Changing default wkhtmltopdf command

    writer = Slim2pdf::Writer.new
    writer.wkhtmltopdf_command = '/your/path/to/wkhtmltopdf --your --params'

Input (html) and output (pdf) files will be added automatically.

## Examples

### Save simple slim template without data to pdf file

    require 'slim2pdf'

    writer = Slim2pdf::Writer.new('simple.slim')
    writer.save_to_pdf('simple.pdf')

See: [doc/examples/simple](https://github.com/macuk/slim2pdf/tree/master/doc/examples/simple)

### Generate agreement with footer

    require 'slim2pdf'

    writer = Slim2pdf::Writer.new('agreement.slim')
    writer.data = {date: '2014-01-14', part1: 'Google', part2: 'Microsoft'}
    writer.footer_text = 'Agreement footer'
    writer.save_to_pdf('agreement.pdf')

See: [doc/examples/agreement](https://github.com/macuk/slim2pdf/tree/master/doc/examples/agreement)

### Generate bulk invoices

    require 'slim2pdf'

    writer = Slim2pdf::Writer.new('invoice.slim')
    buyers = ['Buyer A', 'Buyer B', 'Buyer C', 'Buyer D']
    buyers.each_with_index do |buyer, index|
      number = index + 1
      writer.data = {
        seller: 'Seller', buyer: buyer, number: "#{number}/2014",
        item_name: 'Service', price: '$100', date: '2014-01-14'
      }
      writer.save_to_pdf("invoice-#{number}.pdf")
    end

See: [doc/examples/invoices](https://github.com/macuk/slim2pdf/tree/master/doc/examples/invoices)

## Debuging

### Setting logger

    require 'logger'

    writer = Slim2pdf::Writer.new
    writer.logger = Logger.new(STDERR)

If you use Slim2pdf with Rails, the Rails.logger will be set automatically.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
