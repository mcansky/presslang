class WordSweeper < ActionController::Caching::Sweeper
  observe Word,Definition
  # If our sweeper detects that a Word was created call this
    def after_create(word)
      expire_cache_for(word)
    end

    # If our sweeper detects that a Word was updated call this
    def after_update(word)
      expire_cache_for(word)
    end

    # If our sweeper detects that a Word was deleted call this
    def after_destroy(word)
      expire_cache_for(word)
    end
    private
      def expire_cache_for(word)
        # Expire the index page now that we added a new word/definition
        expire_page(:controller => 'application', :action => 'index')
      end
end