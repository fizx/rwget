require "rubygems"
require "mongrel"


class SimpleHandler < Mongrel::HttpHandler
  def process(request, response)
    response.start(200) do |head,out|
      head["Content-Type"] = "text/html"
      out.write <<-HTML
        <html><head></head><body>
          <a href="../">shallower</a>
          <a href="d/">deeper</a>
        </body></html>
      HTML
      out.write(" " * 80000)
    end
  end
end

h = Mongrel::HttpServer.new("0.0.0.0", "5491")
h.register("/", SimpleHandler.new)

Thread.new do
  h.run.join
end
sleep 1

$webroot = "http://127.0.0.1:5491"