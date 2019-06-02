require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  # step 1. HARVEST
  #  we save the index url that's saved in our fixtures folder to a local variable
  site_html = index_url
  # set a local variable of page to make it easy to read. use open and pass the 
  # site_html variable to feed it the html on the page
  page = open(site_html)

  # ------- HARVEST COMPLETE! -------

  # STEP 2: Filter the Data

  # The idea is to turn that data into Nokigiri Objects to parse thru.
  # create local variable named parsed_students, which is the HTML file
    # we're going to scrape with Nokogiri

  parsed_students = Nokogiri::HTML(page)
  # puts parsed_students.class
    # -- > the class should be a document (Nokogiri::HTML::Document)

    # now it gets complicated, create an empty array called student_array
    student_array = []

    # now we need to iterate thru the parsed_students.css 

    # first level: iterate thru anythign on the HTML page under "div.student-card"
      # that's where they all exist at. we're going to iterate over every student
       # and make hashes out of them by setting each of the ccs elements 
        # that represent their attributes to a key (name:, location:, profile_url:)

    parsed_students.css("div.student-card").each do |student|
      # push every hash that represents a student into the student_array
      student_array.push({
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attribute("href").value
      })
    end
      #return the student_array 
    student_array
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    #scrapes individual student profiles to 
    # get more information 
    profile = Nokogiri::HTML((profile_url))
    binding.pry

    
  end

end

