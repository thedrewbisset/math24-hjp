class ProblemsController < ApplicationController
  def new
    @problem = problem ? problem : Math24.generate_problem
  end

  private
  def problem
    sanitized_problem.map(&:to_i) if flash[:error]
  end

  def sanitized_problem
    params[:problem]
  end
end
