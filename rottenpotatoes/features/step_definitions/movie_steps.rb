#Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create! movie
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #fail "Unimplemented"
  expect(page.body).to match /.*#{e1}.*#{e2}.*/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating| 
    checkbox_id = "ratings_#{rating.strip}" 
    uncheck(checkbox_id) if uncheck 
    check(checkbox_id) unless uncheck 
  end 
end

When "I click the search form on the homepage" do
  click_button('ratings_submit')
end

Then /I should see movies with the following ratings: (.*)/ do |ratings_list|
  ratings_list.split(',').each do |rating| 
    expect(page.all 'td', text: rating)
    #expect(page.body).not_to match /.*#{rating}.*/m unless not_see
  end
end

Then /I should not see movies with the following ratings: (.*)/ do |ratings_list|
  ratings_list.split(',').each do |rating| 
    #expect(page.all 'td', text: rating).empty?
    expect (page.all 'td', text: rating).empty?
    #expect(page.body).not_to match /.*#{rating}.*/m unless not_see
  end
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
    expect (page.all 'tr', count: 11)
end
