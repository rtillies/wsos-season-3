require 'csv'
require 'pry'
require_relative 'team'
require_relative 'game'
require_relative 'division'
require_relative 'processable'
require_relative 'searchable'

class StatTracker
  include Processable
  include Searchable
  attr_reader :teams, :games, :divisions, :output
  
  def initialize(locations)
    @teams = Hash.new
    @games = []
    @divisions = []
    process_divisions(locations[:divs])
    process_teams(locations[:teams])
    process_games(locations[:games])
    process_strength
    process_output(locations[:output])
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
