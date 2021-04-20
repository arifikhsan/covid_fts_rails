class CaseController < ApplicationController
  def index
    @cases = Case.all
  end
end
