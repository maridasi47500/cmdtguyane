class LocationController < ApplicationController
  def instrument
    @post=Post.findbythetitle("instrument")

  end

  def salle
    @post=Post.findbythetitle("salle")

  end
end
