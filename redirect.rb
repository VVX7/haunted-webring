require 'erb'
require 'optparse'
require 'ostruct'
require 'csv'
require 'fileutils'
require 'uri'
require 'open-uri'

options = {
  :output_dir => '_pages/',
  :webring_file => 'webring.txt'
}
OptionParser.new do |opts|
  opts.banner = "Usage: redirect.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end

  opts.on("-oDIR", "--output-dir=DIR", "Output Directory") do |o|
    options[:output_dir] = o
  end

  opts.on("-iFILE", "--webring-file=FILE", "WebRing Links file") do |i|
    options[:webring_file] = i
  end
end.parse!

template = <<-EOF
<!DOCTYPE html>
<meta charset="utf-8">
<title>Redirecting to <%= link %></title>
<meta http-equiv="refresh" content="0; URL=<%= link %>">
<link rel="canonical" href="<%= link %>">
EOF

random_template = <<-EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Random redirect for <%= link %></title>
</head>
<body>
  <noscript>
    Cannot random redirect! Enable Javascript!
  </noscript>
  <script>
    let others = <%= others.to_s %>;
    location.href = others[Math.floor(Math.random()*others.length)];
  </script>
</body>
</html>
EOF

def render(t, vars)
  ERB.new(t).result(OpenStruct.new(vars).instance_eval { binding })
end

class WrapArray < Array
  def [](ind)
    self.fetch(ind%self.length)
  end
end

links = WrapArray.new CSV.parse(URI.open(options[:webring_file]).read).map(&:first)

FileUtils.mkdir_p options[:output_dir]

links.each_with_index do |l, idx|
  host = URI.parse(l).host
  FileUtils.mkdir_p "#{options[:output_dir]}/#{host}"
  File.write("#{options[:output_dir]}/#{host}/next.html", render(template, link: links[idx+1]), mode: 'w+')
  File.write("#{options[:output_dir]}/#{host}/previous.html", render(template, link: links[idx-1]), mode: 'w+')
  File.write("#{options[:output_dir]}/#{host}/random.html", render(random_template, link: l, others: links - [l]), mode: 'w+')
end

File.write("#{options[:output_dir]}/list.html", render(template, link: "https://raw.githubusercontent.com/VVX7/haunted-webring/main/webring.txt"), mode: 'w+')
FileUtils.cp('README.md', options[:output_dir])