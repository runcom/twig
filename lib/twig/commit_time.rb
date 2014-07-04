class Twig

  # Stores a branch's last commit time and its relative time representation.
  class CommitTime
    def self.now
      Time.now
    end

    def initialize(time)
      @time = time
      suffix = 'ago'

      if count_years_ago > 0
        @time_ago = "#{count_years_ago}y #{suffix}"
        return
      end

      if count_months_ago > 0 and count_weeks_ago > 4
        @time_ago = "#{count_months_ago}mo #{suffix}"
        return
      end

      if count_weeks_ago > 0
        @time_ago = "#{count_weeks_ago}w #{suffix}"
        return
      end

      if count_days_ago > 0
        @time_ago = "#{count_days_ago}d #{suffix}"
        return
      end

      if count_hours_ago > 0
        @time_ago = "#{count_hours_ago}h #{suffix}"
        return
      end

      if count_minutes_ago > 0
        @time_ago = "#{count_minutes_ago}m #{suffix}"
        return
      end

      @time_ago = "#{count_seconds}s #{suffix}"
    end

    def count_years_ago
      seconds_in_a_year = 60 * 60 * 24 * 365
      seconds = CommitTime.now - @time
      seconds < seconds_in_a_year ? 0 : (seconds / seconds_in_a_year).round
    end

    def count_months_ago
      now = CommitTime.now
      (now.year * 12 + now.month) - (@time.year * 12 + @time.month)
    end

    def count_weeks_ago
      seconds_in_a_week = 60 * 60 * 24 * 7
      seconds = CommitTime.now - @time
      seconds < seconds_in_a_week ? 0 : (seconds / seconds_in_a_week).round
    end

    def count_days_ago
      seconds_in_a_day = 60 * 60 * 24
      seconds = CommitTime.now - @time
      seconds < seconds_in_a_day ? 0 : (seconds / seconds_in_a_day).round
    end

    def count_hours_ago
      seconds_in_an_hour = 60 * 60
      seconds = CommitTime.now - @time
      seconds < seconds_in_an_hour ? 0 : (seconds / seconds_in_an_hour).round
    end

    def count_minutes_ago
      seconds_in_a_minute = 60
      seconds = CommitTime.now - @time
      seconds < seconds_in_a_minute ? 0 : (seconds / seconds_in_a_minute).round
    end

    def count_seconds
      (CommitTime.now - @time).to_i
    end

    def to_i
      @time.to_i
    end

    def to_s
      time_string = @time.strftime('%F %R %z')
      "#{time_string} (#{@time_ago})"
    end

    def iso8601
      @time.iso8601
    end

    def <=>(other)
      to_i <=> other.to_i
    end
  end
end
