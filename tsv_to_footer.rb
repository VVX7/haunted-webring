require 'csv'

def link(href, title=nil, klass=nil)
	"<a href=\"#{href}\" #{"class=\"#{klass}\"" if klass}rel=\"noreferrer noopener\" target=\"_blank\">#{title || href}</a>"
end

return unless ARGV[0] # First argument is your website link
yoursite = ARGV[0]
output = []
ring_previous = nil
ring_next = nil

rows = CSV.read("webring.tsv", col_sep: "\t").to_a

output << "<p class=\"verbose\">"
rows.each_with_index do |row, idx|
	if yoursite == row[0]
		ring_previous = rows[idx-1][0]
		ring_next = rows[idx+1][0]
	end
end

rows.each_with_index do |row, idx|
	output << "\t"+link(row[0], title=nil, klass=("special" if [ring_previous, ring_next].include? row[0])) + ": " + row[1] + "<br />"
end
output << "</p>"

puts "<!-- BEGIN GENERATED HAUNTED WEBRING -->"

puts "<p>"
puts link(ring_previous, "&lt;"*3, klass="special")
puts "<span class=\"verbose\">This site is part of the </span><a href=\"https://cse.google.com/cse?cx=f667998e7bdfd4464\" rel=\"noreferrer noopener\" target=\"_blank\">Haunted Webring</a>"
puts link(ring_next, "&gt;"*3, klass="special")
puts "</p>"

output.each { |o| puts o }

puts "<!-- END GENERATED HAUNTED WEBRING -->"