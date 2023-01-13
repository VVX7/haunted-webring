require 'csv'

puts "<!-- BEGIN GENERATED HAUNTED WEBRING -->"
puts "<p>This site is part of the <a href=\"https://cse.google.com/cse?cx=f667998e7bdfd4464\" rel=\"noreferrer noopener\" target=\"_blank\">Haunted Webring</a></p>"

def link(href)
	"<a href=\"#{href}\" rel=\"noreferrer noopener\" target=\"_blank\">#{href}</a>"
end

puts "<p>"
CSV.read("webring.tsv", col_sep: "\t").each do |row|
	puts "\t"+link(row[0]) + ": " + row[1] + "<br />"
end
puts "</p>"
puts "<!-- END GENERATED HAUNTED WEBRING -->"