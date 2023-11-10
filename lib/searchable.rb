module Searchable
  def find_by_name(name_stub)
    @teams.each do |c, team|
      if team.team_name.downcase.include? (name_stub)
        return team
      end
    end
  end

  def find_by_code(code)
    @teams.each do |c, team|
      if team.code.include? (code)
        return team
      end
    end
  end

  def get_team
    puts "Enter team name: "
    team_stub = STDIN.gets.chomp
    team = find_by_name(team_stub.downcase)
    # puts "Team name: #{team.team_name}"
    # team
  end

  def get_choice
    puts "(C)onf | (D)iv  | (N)on-Conf"
    puts "(H)ome | (A)way | (W)ins | (L)oss"
    puts "(T)eam | (P)layed | (F)orfeits"
    puts "(X) All Games"
    # puts "(C)onf | (D)iv  | (H)ome | (A)way"
    # puts "(W)ins | (L)oss | (T)eam | (P)layed"
    # puts "(N)on-Conf | (X) All Games"
    print "Option: "
    choice = STDIN.gets.chomp
  end

  def show_games(team)
    code = team.code

    selected = @games.select {|game| game.home_code == code || game.away_code == code}

    tdraws = team.draws > 0 ? "-#{team.draws}" : ""
    tdoubles = team.double_forfeit > 0 ? "-#{team.double_forfeit}" : ""

    puts "="*35
    puts "#{team.team_name} (#{team.wins}-#{team.losses}#{tdraws}#{tdoubles})"
    puts "#{team.conference} Conference"
    puts "#{team.division} Division"
    puts "="*35
    message = "All games"
    choice = get_choice.upcase
    
    if choice == "C"
      message = "Conference games"
      selected.select! {|game| game.conf_game?}
    elsif choice == "D"
      message = "Division games"
      selected.select! {|game| game.div_game?}
    elsif choice == "H"
      message = "Home games"
      selected.select! {|game| code == game.home_code}
    elsif choice == "A"
      message = "Away games"
      selected.select! {|game| code == game.away_code}
    elsif choice == "W"
      message = "Games won"
      selected.select! {|game| code == game.winning_team}
    elsif choice == "L"
      message = "Games lost"
      selected.select! {|game| code == game.losing_team}
    elsif choice == "N"
      message = "Non-conference games"
      selected.select! {|game| !game.conf_game?}
    elsif choice == "T"
      other = get_team
      message = "Games vs #{other.team_name}"
      selected.select! {|game| game.home_code == other.code || game.away_code == other.code}
    elsif choice == "P"
      message = "Played games"
      selected.select! {|game| game.played?}
    elsif choice == "F"
      message = "Forfeited games"
      selected.select! {|game| !game.played?}
    end

    puts message + " (#{selected.size}):"

    selected.each do |game|
      date = game.date

      if game.home_code == code || game.away_code == code
        if code == game.home_code
          home_away = "HOME"
          other_code = game.away_code
        else
          home_away = "AWAY"
          other_code = game.home_code
        end

        if game.div_game?
          div_conf = "DIV "
        elsif game.conf_game?
          div_conf = "CONF"
        else
          div_conf = "NONC"
        end

        other_team_name = find_by_code(other_code).team_name

        if code == game.winning_team
          win_loss = "WIN "
          score1 = game.winning_score
          score2 = game.losing_score
        else
          win_loss = "LOSS"
          score2 = game.winning_score
          score1 = game.losing_score
        end

        # score_msg = game.forfeit? ? " -FORFEIT-" : score1.to_s.rjust(4) + " | " + score2.to_s.rjust(4)
        if game.double_forfeit?
          score_msg = " *-DOUBLE-*"
        elsif game.forfeit?
          score_msg = " -FORFEIT-"
        else
          score_msg = score1.to_s.rjust(4) + " | " + score2.to_s.rjust(4)
        end

        puts "  #{date}  #{home_away}  #{div_conf}  " + win_loss.ljust(6) + other_team_name.ljust(20) + score_msg
      end
    end
  end
end
