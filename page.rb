require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Page
  attr_accessor :links_array, :url

  def initialize()
     @url = url
     @links_array = []
  end

  def links(url)
     uri = URI(url)
     document = Nokogiri::HTML(open(url))
     document.css("a").each do |link|
         if(link['href'])&&(link['href'].match(/https/))
	  @links_array << link['href']
	 else
	  if (link['href'])&&(!link['href'].match(/#ja-/))
	     if (link['href'])&&(!link['href'].match(/^http:/))
	        @links_array << "http://"+uri.host+(link['href'])
             else
	        @links_array << link['href']
             end
          end
	 end 
     end
#     document.css("a").each {|l| @link_array}
     @links_array.each{|l| puts l}
     @links_array
  end    
end

c = Page.new()
c.links("http://www.google.com")
