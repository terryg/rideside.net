# frozen_string_literal: true

class SinatraApp
  # Reply to the comment you are replying to
  class CommentGraph
  end

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
      comments_for_node = comments.by_nid(@node[:nid]).join(:users, uid: :uid)

      comments_for_node.each do |comment|
      end

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
        body_text = params[:body]
        timestamp = Time.now

        client.text("#{@current_user.name}.tumblr.com", {
                      title: timestamp.strftime('%Y-%m-%d %H:%M'),
                      body: body_text,
                      tags: [params[:tag_names]]
                    })
      else
        puts 'ERROR - POST / - Current User is nil!'
      end

      redirect '/'
    end
  end
end
