class ExercisesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_exercise, except: [:index, :new, :create]

  def index

  end

  def show

  end

  def new
    @exercise = current_user.exercises.build
  end

  def create
    @exercise = current_user.exercises.build(exercise_params)
    if @exercise.save
      flash[:success] = 'Exercise has been created.'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      flash.now[:danger] = 'Exercise has not been created.'
      render 'new'
    end
  end


  private
  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date)
  end

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end
end