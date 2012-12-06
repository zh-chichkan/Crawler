require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Page
  attr_accessor :url, :url_array, :index, :uri, :i, :flag
  # attr_writer :url_array

  def initialize(url, index)
     @index = index
     @url = url
     @url_array = []
     @uri = []
     @i = 0
     @flag = true
  end

  def content
     open(@url)
  end

  def document
     @document ||= Nokogiri::HTML(content)
  end

  def links
     document.css("a").each {|link| @url_array << link["href"]}
     @url_array.each{|l| puts l}
  end  
  
  def crawler
    if @i == @index
       "END"  
    else
      if @url != nil
         self.links
      end    
    end
    
    if @flag == true
       @uri = @url_array
       @url_array = []
       self.craw 
    end 
  end
 
  def craw
    @uri.each do |l|
       @url = l
       @flag = false
       self.crawler
    end
    @url = nil
    @i += 1
    self.crawler
  end
end

c = Page.new("http://www.google.com", 3)
puts c.crawler
