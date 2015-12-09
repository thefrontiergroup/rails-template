class UriQueryMerger

  attr_reader :params, :uri

  def initialize(uri, params)
    @params = params
    @uri    = uri
  end

  def merge
    new_uri = URI.parse(uri)
    new_uri.query = merged_query
    new_uri.to_s
  end

private

  def merged_query
    new_query = params.stringify_keys
    new_query = new_query.reverse_merge(CGI.parse(URI.parse(uri).query)) if URI.parse(uri).query.present?
    URI.encode_www_form(new_query.to_a)
  end

end
