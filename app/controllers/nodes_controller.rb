# frozen_string_literal: true

class SinatraApp
  # Handles requests to '/nodes'
  class NodesController
    get '/:id' do
      nodes = MAIN_CONTAINER.relations[:nodes]
      @node = nodes.by_pk(params[:id]).one!

      created = Time.at(@node[:created])
      @year = created.year
      @month = created.month.to_s.rjust(2, '0')
      @day = created.day.to_s.rjust(2, '0')

      node_revs = MAIN_CONTAINER.relations[:node_revisions]
      @node_rev = node_revs.where(nid: @node[:nid]).last

      comments = MAIN_CONTAINER.relations[:comments]
      @comments = comments.by_nid(@node[:nid]).join(:users, uid: :uid)

      puts '=== @comments ==='
      puts @comments

      users = MAIN_CONTAINER.relations[:users]
      @user = users.by_pk(@node[:uid]).one!

      haml :node, escape_html: false
    end

    post '/' do
      if current_user
        Tumblr.configure do |config|
          config.consumer_key = ENV['TUMBLR_CONSUMER_KEY']
          config.consumer_secret = ENV['TUMBLR_CONSUMER_SECRET']
          config.oauth_token = @current_user.access_token
          config.oauth_token_secret = @current_user.access_token_secret
        end

        client = Tumblr::Client.new

        puts '***** made client'

        body_text = params[:body]

        timestamp = Time.now

        puts '**** Starting...'

        client.text("#{@current_user.name}.tumblr.com", {
                      title: timestamp.strftime('%Y-%m-%d %H:%M'),
                      body: body_text,
                      tags: [params[:tag_names]]
                    })

        puts '**** Done.'
      else
        puts '**** Current User is nil!'
      end

      redirect '/'
    end
  end
end
