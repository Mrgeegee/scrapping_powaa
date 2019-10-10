require 'rubygems'
require 'nokogiri'
require 'open-uri'

Hash.class_eval do
    def split_into(divisions)
    count = 0
    inject([]) do |final, key_value|
        final[count%divisions] ||= {}
        final[count%divisions].merge!({key_value[0] => key_value[1]})
        count += 1
        final
    end
end
end


PAGE_UREL = ""
page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
nom_mairie = page.xpath('///a[@class="lientxt"]')
nom_mairie_array = Array.new
nom_mairie.each do |x|
    nom_mairie_array << x.text
end

email_mairie_array = Array.new
i = 0

while i < nom_mairie_array.size
    mam = nom_mairie_array[i].downcase.tr(" ", "-")
    page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/95/#{mam}.html"))
    email_mairie = page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
    email_mairie_array << email_mairie.text
    i = i + 1
end

hashoux = {}
hash_principal = Array.new
hashoux = Hash[nom_mairie_array.zip(email_mairie_array)]
hash_principal = hashoux.split_into(185)

puts hash_principal

