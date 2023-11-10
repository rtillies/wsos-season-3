require_relative 'game'
require_relative 'team'
require_relative 'division'

class Team
  attr_reader :code, :team_name, :conference, :division, :captain, :teammate, :location
  attr_accessor :wins, :losses, :draws, :total_score, :opp_score,
                :hwins, :hloss, :awins, :aloss, 
                :pwins, :ploss, :fwins, :floss, :double_forfeit,
                :dwins, :dloss, :cwins, :closs, :percentage, :played_percent,
                :strength_schedule, :strength_victory
  
  def initialize(row)
    @code = row[0]
    @team_name = row[1]
    @conference = row[2]
    @division = row[3]
    @captain = row[4]
    @teammate = row[5]
    @location = row[6]
    @wins = @losses = @draws = @double_forfeit = 0
    @total_score = @opp_score = 0
    @hwins = @hloss = @awins = @aloss = 0
    @dwins = @dloss = @cwins = @closs = 0
    @pwins = @ploss = @fwins = @floss = 0
    @strength_schedule = @strength_victory = 0
  end

  def differential
    @total_score - @opp_score
  end

  def avg_diff
    played = @pwins + @ploss + @draws
    played > 0 ? (differential.to_f / played).round(1) : "n/a"
  end

  def forfeits 
    fwins + floss + double_forfeit
  end

  def percentage
    (wins.to_f / (wins + losses + draws + double_forfeit)).round(3)
  end

  def played_percent
    played = @pwins + @ploss + @draws
    played > 0 ? (@pwins.to_f / played).round(3) : "n/a"
  end
end