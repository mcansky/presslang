# encoding : UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  cache_sweeper :word_sweeper
  caches_action :index

  def index
    words = Word.find(:all, :limit => 10, :order => "updated_at DESC")
    @words = Array.new
    words.each { |w| @words << w unless w.banned? }
  end

  def show
  end
end
