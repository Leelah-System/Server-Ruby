# http://stackoverflow.com/questions/8961367/aptana-3-ruby-debugger-exception-in-debugthread-loop-undefined-method-is-bin/9065557#9065557
class String
  def is_binary_data?
    ( self.count( "^ -~", "^\r\n" ).fdiv(self.size) > 0.3 || self.index( "\x00" ) ) unless empty?
  end
end

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LeelahSystemServer::Application.initialize!
