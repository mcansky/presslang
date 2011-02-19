# encoding : UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    words = Word.find(:all, :limit => 10, :order => "created_at DESC")
    @words = Array.new
    words.each { |w| @words << w unless w.banned? }
  end

  def show
  end
end
