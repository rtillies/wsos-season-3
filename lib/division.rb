require_relative 'game'
require_relative 'team'
require_relative 'division'

class Division
  attr_reader :code,
              :division,
              :conference,
              :abbreviation
  
  def initialize(row)
    @code = row[0]
    @division = row[1]
    @conference = row[2]
    @abbreviation = row[3]
  end
end