class String
  def split_sentence
    array = self.gsub(/\n/," ").split(/([^\.\?\!]+[\.\?\!]+)/)
    array.delete("")
    sentences = Array.new
    str = ""
    for i in 0..array.size-1
      next if array[i].size == 0 || array[i] =~ /^\s*$/
      str << array[i]
      # abr with more or equal than 3 letters
      next if str =~ /((Mr|Mrs|Ms|Dr|Mt|St)\.)$/
      if (i < array.size-1)
        ## abbreviation stuff
        # should not end with big letter
        next if array[i] =~ /([A-ZÄÖÜ\d])\.$/
        # next should start with big letter
        next if array[i+1] =~ /^[\s\"]*[a-z\.]/

        # should end with at least 2 letters plus point
        next if array[i][/[^\s]*?\.$/] && array[i][/[^\s]*?\.$/].size < 3
        #end abbreviation stuff

        if match = array[i+1][/^(["\)']|\“)/]
          str << match
          array[i+1].sub!(/^#{match}/,"")
        end
      end
      sentences << str.sub(/^\s+/,"")
      str = ""
    end
    sentences
  end

  def crop(range)
    return nil if self.size < range.begin
    sentences=self[0..range.end].split_sentence
    return nil unless sentences.first.is_full_sentence?
    sentences.pop unless sentences.last.is_full_sentence?
    text=sentences.join(" ")
    text.size >= range.begin ? text : nil

  end

  def is_full_sentence?
    self =~/^([A-ZÄÖÜ"\)']|\“).*?[\.\?\!](["\)']|\“)?$/ ? true : false
  end

end