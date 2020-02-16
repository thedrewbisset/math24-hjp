class SolutionsController < ApplicationController
  def create
    if Math24.check(problem, solution)
      redirect_to new_problem_url, flash: { notice: "You got it right, rock on!" }
    else
      redirect_to new_problem_url(params: { problem: problem }), flash: { error: "Incorrect" }
    end
  end

  private
  def problem
    sanitized_problem.values.map(&:to_i)
  end

  def solution
    sanitized_solution.inject("") do |acc, (k,v)|
      acc += v
    end
  end

  def sanitized_problem
    params[:problem].permit(:first_number, :second_number, :third_number, :fourth_number).to_h
  end

  def sanitized_solution
    params[:solution].permit(:first_number, :first_operator, :second_number, :second_operator, :third_number, :third_operator, :fourth_number).to_h
  end
end
