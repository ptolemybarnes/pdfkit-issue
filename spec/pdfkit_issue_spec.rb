require 'pdfkit'

describe "pdfkit issue" do

  it 'uses latest version of wkhtmltopdf' do
    # installed with `brew install wkhtmltopdf`
    version = `wkhtmltopdf --version`.chomp

    expect(version).to eq("wkhtmltopdf 0.12.6 (with patched qt)")
  end

  it 'explodes' do
    template = <<~TEMPLATE
    <html>
      <head></head>
      <body>
        <div>
          <img src=/Users/Home/example.png>
        </div>
      </body>
    </html>
    TEMPLATE

    expect do
      PDFKit.new(template).to_pdf
    end.to raise_exception(PDFKit::ImproperWkhtmltopdfExitStatus)
  end

  it 'works' do
    PDFKit.configure do |config|
      config.default_options = {
        :enable_local_file_access => true
      }
    end

    template = <<~TEMPLATE
    <html>
      <head></head>
      <body>
        <div>
          <img src=/Users/Home/example.png>
        </div>
      </body>
    </html>
    TEMPLATE

    PDFKit.new(template).to_pdf
  end
end
