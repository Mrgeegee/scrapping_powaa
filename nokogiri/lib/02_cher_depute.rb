require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://www.nosdeputes.fr/deputes"))
nom_depute = page.xpath('///span[@class="list_nom"]')
nom_depute_array = Array.new
nom_depute.each do |x|
    nom_depute_array << x.text
end



email_depute_array = Array.new

i = 0

while i < nom_mairie_array.size
    mam = nom_mairie_array[i].reverse.tr(" ", "-")
    page = Nokogiri::HTML(open("https://www.nosdeputes.fr/#{mam}"))
    email_mairie = page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
    email_mairie_array << email_mairie.text
    i = i + 1
end
