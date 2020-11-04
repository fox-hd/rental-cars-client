class SubsidiariesController < ApplicationController

  def index
    @subsidiaries = Subsidiary.get_subsidiaries
  end


end