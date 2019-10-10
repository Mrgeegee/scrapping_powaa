
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

#def extract_info
# split_into

    stream = open("https://coinmarketcap.com/all/views/all/")
    html = Nokogiri::HTML(stream.read)
    
    
    
    name = html.search('///*[@id]/td[3]')
     array_name=Array.new
     name.each do |x|
         array_name << x.text
    end
    
    
    value = html.search('//a[@class="price"]')
    array_price=Array.new
    hash_principal = {}
    value.each do |x|
        array_price << x.text
        
    end

    hash_principal=Hash[array_name.zip(array_price)]
    split_fin = hash_principal.split_into(2398)
    
#end
    
puts split_fin
