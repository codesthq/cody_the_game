# Write such a code that allows to use ~:foo syntax in 'case' statement like this:

case any_object
when ~:foo
  # any_object responds to :foo method
when ~:bar
  # any_object responds to :bar method
else
  # any_object does not respond to :foo or :bar methods
end
