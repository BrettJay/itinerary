class ReadingTime < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def reading_time(input)
      words_per_minute = 180

      words = input.split.size
      minutes = (words/words_per_minute).floor
      minutes_label = minutes === 1 ? ' minute' : ' minutes'
      minutes > 0 ? "about #{minutes} #{minutes_label}" : 'less than 1 minute'
    end

    def time_label(input)
      words_per_minute = 180

      words = input.split.size
      minutes = (words/words_per_minute).floor
      minutes_label = minutes === 1 ? ' minute' : ' minutes'
      minutes > 0 ? "#{minutes} #{minutes_label}" : 'Under 1 minute'
    end
  end
end

::Middleman::Extensions.register(:reading_time, ReadingTime)
