# frozen_string_literal: true

require './app/project'

class SinatraApp
  # Handles requests to '/~tgl'
  class TglController
    get '/' do
      @projects = Project.make

      @cards = []
      text = File.read(File.join('app', 'projects.txt'))
      text.each_line do |line|
        c = line.split(',')
        @cards << [c[0], c[1]]
      end

      haml :tgl, layout: false
    end

    get '/italian-cookies' do
      haml :italian_cookies, layout: false
    end

    get '/jeff-varasanos-ny-pizza-recipe' do
      haml :jeff_varasanos_ny_pizza_recipe, layout: false
    end

    get '/kombucha' do
      haml :kombucha, layout: false
    end

    get '/stuffed-quahog' do
      haml :stuffed_quahog, layout: false
    end
  end
end
