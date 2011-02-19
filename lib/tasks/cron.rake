# encoding : UTF-8
require 'digest/sha1'
task :cron => :environment do
  search = Twitter::Search.new
  already_done = false
  twits = Array.new
  defins = search.hashtag("presslang").language("fr").no_retweets.per_page(20).fetch
  @defins = defins
  while !already_done
    raise RuntimeError, "lost the messages" if (!@defins || (@defins.size == 0))
    defins = @defins
    defins.each do |a_def|
      # check if the definition is already in (1 tweet = 1 definition so if we already have
      # tweet id in ...)
      if Definition.find_by_twitter_id(a_def["id_str"])
        already_done = true
      else
        twits << a_def
      end
    end
    defins = search.fetch_next_page unless already_done
    already_done = true if !defins
  end
  if twits.size > 0
    twits.each do |definition|
      bad_twit = false
      sanitized = definition.text.gsub(%r{#[a-zA-Z0-9]+ *},'').gsub(%r{@[a-zA-Z0-9]+ *},'').gsub(/[«»]/,'').gsub("&quot;",'')
      sdef = sanitized.split(":")
      word = sdef.first.gsub(%r{^ +},'').chomp
      author = definition["from_user"]
      twitter_id = definition["id_str"]
      twitted_at = definition["created_at"]
      Rails.logger.info("Treating #{twitter_id}")
      message = ""
      if sdef.size == 2
        message = sdef[1].gsub(%r{^ +},'')
      elsif sdef.size > 2
        message = sanitized.gsub(word,'').gsub(%r{^ +},'').gsub(%r{^: },'').gsub(%r{ $},'')
      else
        bad_twit = true
      end
      if bad_twit
        # we got a bad twit let's trash it
        def_w = Definition.new(:banned => true,
          :definition => "bad message",
          :sha => Digest::SHA1.hexdigest("bad message"),
          :twitter_id => twitter_id,
          :author => author,
          :twitted_at => twitted_at)
        if def_w.save
          Rails.logger.info("#{twitter_id} is incorrect")
        else
          Rails.logger.warn("#{twitter_id} is incorrect, could not save #{def_w.errors}")
        end
      else
        sha = Digest::SHA1.hexdigest(message)

        # we already know that the definition is not in there
        def_w = Definition.new(:definition => message, :sha => sha, :twitter_id => twitter_id, :author => author, :twitted_at => twitted_at)

        # let's find the word then
        word_w = nil
        word_w = Word.find_by_word(word)
        unless word_w
          # we don't have the word yet, let's create it
          word_w = Word.new(:word => word, :lang => 'fr')
        end
        # we got the word, let's add a def to it
        word_w.definitions << def_w
        if word_w.save
          Rails.logger.info("#{twitter_id} has been added")
        else
          Rails.logger.warn("#{twitter_id} error : #{word_w.errors}")
        end
      end
    end
  end
end