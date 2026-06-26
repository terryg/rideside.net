# frozen_string_literal: true

class SinatraApp
  # Handles requests to '/archive'
  class ArchiveController
    get '/' do
      if params[:q].nil?
        nodes = MAIN_CONTAINER.relations[:nodes]

        min = Time.at(nodes.first[:created]).strftime('%Y')
        max = Time.at(nodes.last[:created]).strftime('%Y')
        @years = (min.to_i..max.to_i).step(1)
        @nodes = []
      else
        @years = []

        revs = NodeRevision.all(:body.like => "%#{params[:q]}%")
        comments = Comment.all(:comment.like => "%#{params[:q]}%")

        @nodes = []

        revs.each do |r|
          @nodes << r.node
        end

        comments.each do |c|
          @nodes << c.node
        end
      end

      @months = []

      haml :archive
    end

    get '/:year' do
      @year = params[:year]
      @years = []
      @months = ('01'..'12')
      @nodes = []
      haml :archive
    end

    get '/:year/:month' do
      @year = params[:year]
      @month = params[:month]

      year = @year.to_i
      month = @month.to_i

      pos = Date.new(year, month, 1).to_time.to_i

      if month == 12
        year += 12
        month = 1
      else
        month += 1
      end

      npos = Date.new(year, month, 1).to_time.to_i

      @nodes = MAIN_CONTAINER.relations[:nodes].where do
        (created > pos) & (created < npos)
      end

      @years = []
      @months = []
      haml :archive
    end

    get '/:year/:month/:day' do
      @year = params[:year]
      @month = params[:month]
      @day = params[:day]

      year = @year.to_i
      month = @month.to_i
      day = @day.to_i

      pos = Date.new(year, month, day).to_time.to_i

      npos = pos - (60 * 60 * 24)

      @nodes = MAIN_CONTAINER.relations[:nodes].where do
        (created > pos) & (created < npos)
      end

      @years = []
      @months = []
      haml :archive
    end
  end
end
