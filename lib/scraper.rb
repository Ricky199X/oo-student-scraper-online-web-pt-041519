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

    site_html = profile_url
    page = open(site_html)
    profile = Nokogiri::HTML(page)

    social_media_hash = {}
    # social links exist in "div social-icon-container"
    # social links : profile.css("a").attribute("href").value
    # social_media_hash[:blog] = profile.css("div social-icon-container")

    profile.css("div.social-icon-container a").each do |href|
      link = href.attribute("href").value
      # set up regex to assign each social link to a variable, make it a key of the hash
      if link.match(/.twitter.com/)
        social_media_hash[:twitter] = link
      elsif link.match(/.linkedin.com/)
        social_media_hash[:linkedin] = link
      elsif link.match(/.github.com/)
        social_media_hash[:github] = link
      else
        social_media_hash[:blog] = link
      end

      social_media_hash[:profile_quote] = profile.css("div.profile-quote").text
      social_media_hash[:bio] = profile.css("p").text
      
    end
      # return the social_media_hash
    social_media_hash
  end

end

