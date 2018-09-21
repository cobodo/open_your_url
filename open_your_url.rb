Plugin.create(:open_your_url) do
  on_show_tweet do |id|
    Thread.new {
      Message.findbyid(id)
    }.next { |messages|
      if messages.is_a? Enumerable
        messages = messages.compact
      else
        messages = [messages]
      end
      Plugin.call(:open_smartthread, messages) unless messages.empty?
    }
  end

  on_open_your_url do |urls|
    urls = [urls] unless urls.is_a?(Array)

    urls.each do |url|
      model_class = Enumerator.new{ |y|
        Plugin.filtering(:model_of_uri, url, y)
      }.lazy.map{ |model_slug|
        Diva::Model(model_slug)
      }.find{ |mc|
        mc.spec.timeline
      }
      next unless model_class

      Delayer.Deferred.new{
        model_class.find_by_uri(url)
      }.next{ |model|
        Plugin.call(:open_smartthread, [model])
      }
    end
  end

  command(:open_your_url,
    name: 'URLで開く',
    condition: lambda{|opt| true},
    visible: true,
    icon: File.join(File.dirname(__FILE__),"md-open.png"),
    role: :window) do |opt|

    dialog "URLを入力してください" do
      input "URL", :url
    end.next do |result|
      url = Diva::URI.new(result[:url])
      Plugin.call(:open_your_url, url)
    end
  end
end
