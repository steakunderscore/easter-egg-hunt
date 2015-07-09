require 'rubygems'
require 'mechanize'
require 'pry'
require 'pry-byebug'

FILE="/tmp/torpedo7_egg_hunt.ymal"

agent = Mechanize.new

page = agent.get 'https://www.torpedo7.co.nz/sitemap.do'

links = page.links_with(href: /(products|shop)/)

links.each do |link|
  begin
    product_page = agent.get(link.href)
    if product_page.images_with(src: /Marmot_Easter_Egg_Hunt/).count > 0
      puts "###### FOUND ONE: #{product_page.href}"
      binding.pry
    end
  rescue => e
    puts "Got error on #{link.href}"
  end
end

puts 'end'

