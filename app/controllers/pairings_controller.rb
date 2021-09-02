class PairingsController < ApplicationController
    before_action :set_pairing, only: [:show, :edit, :update]

  def index
    @pairings = Pairing.all
  end

  def new
    @pairing = Pairing.new
  end

  def create
    @pairing = Pairing.new(pairing_params)
    # @pairing.movie =
    # @pairing.food =
    if @pairing.save
      redirect_to pairing_path(@pairing)
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    @pairing.update(pairing_params)
    redirect_to pairing_path(@pairing)
  end

  def destroy
    @pairing.destroy
    redirect_to pairings_path
  end

  def otp
    @movies = Movie.joins(:genres).select { |movie| movie.genres.map(&:name).any? { |genre| params[:otp].values.include?(genre)} }.uniq
  # @movies = Movie.select { |movie| movie.year <= minyear && movie.year >= maxyear }

    @movies = @movies.sample
    @foods = Food.all.sample
  end

  private

  def set_pairing
    @pairing = Pairing.find(params[:id])
  end

  def pairing_params
    params.require(:pairing).permit(:movie, :food)
  end
end
