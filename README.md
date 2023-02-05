# Haunted Webring

A haunted webring. this repository implements a double-linked list that you can query.

here is the full list of domains in the webring right now: https://github.com/VVX7/haunted-webring/blob/main/webring.txt

usage
usage: next | previous | random | list

next
GET /haunted-webring/pixeldreams.tokyo/next
redirects to the site immediately BEFORE https://pixeldreams.tokyo/

previous
GET /haunted-webring/pixeldreams.tokyo/previous
redirects to the site immediately AFTER https://pixeldreams.tokyo/

random
GET /haunted-webring/pixeldreams.tokyo/random
redirects to a random site in the ring EXCEPT https://pixeldreams.tokyo/, it requires Javascript

list
GET /haunted-webring/list
returns the hard-coded list of domains in the webring in text/plain

html tag
paste this into your html and modify how you like! (don't forget to edit the domain part)

<p>
  <a href='https://vvx7.github.io/haunted-webring/<your host>/previous'>&lt;&lt;&lt;</a>
  this site is part of the <a href='https://vvx7.github.io/haunted-webring/README.md'>[haunted webring]</a> 
  <a href='https://vvx7.github.io/haunted-webring/<your host>/next'>&gt;&gt;&gt;</a>
</p>