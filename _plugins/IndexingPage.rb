module Jekyll

  class Page
    # @origin https://github.com/kinnetica/jekyll-plugins/blob/master/sitemap_generator.rb
    attr_accessor :name

    def full_path_to_source
      File.join(@base, @dir, @name)
    end

    def absolute_url
      "#{@dir}#{url}"
    end
  end

end
