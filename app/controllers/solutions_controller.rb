class SolutionsController < ApplicationController
  def create
    record_score
    if solved?
      redirect_to new_problem_url, flash: { notice: "You got it right, rock on!" }
    else
      redirect_to new_problem_url(params: { problem: problem }), flash: { error: "Incorrect, try again!" }
    end
  end

  private
  def record_score
    build_scorecard unless session['scorecard']
    session['scorecard']['attempts'] += 1
    if solved?
      session['scorecard']['correct'] += 1
    else
      session['scorecard']['incorrect'] += 1
    end
  end

  def build_scorecard
    session['scorecard'] = HashWithIndifferentAccess.new({ attempts: 0, correct: 0, incorrect: 0 })
  end

  def solved?
   @solved ||= Math24.check(problem, solution)
  end

  def problem
    sanitized_problem.values.map(&:to_i)
  end

  def solution
    sanitized_solution.select{|k| !%w(group_two group_three group_two_pair).include?(k)}.inject("") do |acc, (k,v)|
      acc += if sanitized_solution[:group_two]
        if k == 'first_number'
          "(#{v}"
        elsif k == 'second_number'
          "#{v})"
        else
          v
        end
      elsif sanitized_solution[:group_three]
        if k == 'first_number'
          "(#{v}"
        elsif k == 'third_number'
          "#{v})"
        else
          v
        end
      elsif sanitized_solution[:group_two_pair]
        if %w(first_number third_number).include? k
          "(#{v}"
        elsif %w(second_number fourth_number).include? k
          "#{v})"
        else
          v
        end
      else
        v
      end
    end
  end

  def sanitized_problem
    params[:problem].permit(:first_number, :second_number, :third_number, :fourth_number).to_h
  end

  def sanitized_solution
    params[:solution].permit(:first_number, :first_operator, :second_number, :second_operator, :third_number, :third_operator, :fourth_number, :group_two, :group_three, :group_two_pair).to_h
  end
end
