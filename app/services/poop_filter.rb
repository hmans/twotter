module PoopFilter
  module_function

  URL = "https://poopfilter.herokuapp.com/filter"

  def filter(text)
    HTTParty
      .post(URL, query: { text: text })
      .parsed_response["output"]
  end
end
