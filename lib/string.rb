class String
  def split_sentence
    ary = self.gsub(/\n/," ").split(/([^\.\?\!]+[\.\?\!]+)/)
    ary.delete("")
    sentences = Array.new
    str = ""
    for i in 0..ary.size-1
      next if ary[i].size == 0 || ary[i] =~ /^\s*$/
      str << ary[i]
      # abr with more or equal than 3 letters
      next if str =~ /((Mr|Mrs|Ms|Dr|Mt|St)\.)$/
      if (i < ary.size-1)
        ## abbreviation stuff
        # should not end with big letter
        next if ary[i] =~ /([A-Z\d])\.$/
        # next should start with big letter
        next if ary[i+1] =~ /^[\s\"]*[a-z\.]/

        # should end with at least 2 letters plus pont
        next if ary[i][/[^\s]*?\.$/] && ary[i][/[^\s]*?\.$/].size < 3
        #end abbreviation stuff

        if ary[i+1] =~ /^\"/
          str << '"'
          ary[i+1].sub!(/^\"/,"")
        elsif ary[i+1] =~ /^\)/
          str << ')'
          ary[i+1].sub!(/^\)/,"")
        #elsif punct = ary[i+1][/^[\.\?\!]+/]
        #  str << punct
        #  ary[i+1].sub!(/^[\.\?\!]+/,"")
        end
      end
      sentences << str.sub(/^\s+/,"")
      str = ""
    end
    sentences
  end
end

#Ò #ã