#require 'test_helper'
require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../lib/string.rb")
class StringTest < Test::Unit::TestCase
  def setup

    @s=[]
    @s<<"Ein Satz."
    @s<<"Ein zweiter Satz."
    @s<<"\"Alles wird gut.\" sagte Schröder."
    @s<<"Meyer antwortet:\"Das habe ich so nie gesagt.\""
    @s<<"\"So ein Unfug.\""
    @s<<"Meyer antwortet:\"Das habe ich so nie gesagt.\" und ging."
    @s<<"Meyer antwortet:\„Das habe ich so nie gesagt.\“"
    @s<<"Meyer antwortet:\'Das habe ich so nie gesagt.'"
    @s<<"What's up?"
    @s<<"Nothing is going on!"
    @s<<"Really noting!!!"
    @s<<"Findet am 1. Mai statt."
    @s<<"King Lui III. was the 3rd King."
    @s<<"Ein Abkürzung mfrgÄ. Birnen funktionieren."

    @str=@s.join(" ")
  end

  def test_sentences
    assert_equal [],@str.split_sentence - @s
  end
  def test_crop
    @s.inject do |text,s|
      text << " "+s
      assert_equal text, @str.crop(text.size..text.size)
      assert_equal text, @str.crop((text.size-1)..(text.size+1))
      assert_not_equal text,@str.crop((text.size+1)...(text.size+2))
      text
    end

  end


  def test_crop_return_nil
    assert_equal nil, "Ein zu langer Satz der gekürzt werden muss.".crop(45..50)
  end
  def test_incomlete_sentence
    assert !"Kein ganzer Satz".is_full_sentence?
  end
  def test_comlete_sentence
    assert "Ein ganzer Satz.".is_full_sentence?
  end
  def test_comlete_question
    assert "Eine vollständige Frage?".is_full_sentence?
  end
  def test_comlete_sentence_ends_on_bracked
    assert "Ein ganzer Satz (der geklammert ist.)".is_full_sentence?
  end
  def test_complete_sentence_with_umlaut
    assert "\"Alles wird gut.\" sagte Schröder.".is_full_sentence?
    end
  def test_complete_sentence_with_special_chars
    assert "\“Alles wird gut.\“ sagte Schröder.".is_full_sentence?
  end
end