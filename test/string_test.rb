# coding: utf-8
#require 'test_helper'
require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../lib/string.rb")
class StringTest < Test::Unit::TestCase
  def setup
    @string = "Ich bin ein Satz. Ein zweiter Satz! Und eine Frage? Am 15. Mai 2010 feiere ich die Arbeit."
    @string << "Einige Abkürzungen für Mrs. Kniep sind schon eingebaut."
    @string << "Eine Abkürzung z.B. in einem Satz macht u.a. usw. keinen Sinn."
    @string << "Am Ende des Satzes heißt es warten..."
    @string << "Das wars !!!"
    @string << "Aber auch Römische Zahlen funktionieren der MXMII. König meint: \"alles wird gut...\"."
    @sentences = @string.split_sentence
    @s=[]
    @s<<"Ein Satz."
    @s<<"Ein zweiter Satz."
    @s<<"\"Alles wird gut.\" sagte Schröder."
    @s<<"Meyer antwortet:\"Das habe ich so nie gesagt.\""
    @s<<"\"So ein Unfug.\""
    @s<<"Meyer antwortet:\"Das habe ich so nie gesagt.\" und ging"
    @str=@s.join(" ")
  end

  def test_all
    assert_equal @s,@str.split_sentence
  end

  def test_split_on_dot
    assert_equal "Ich bin ein Satz.", @sentences.first
  end
  def test_split_on_?
    assert_equal "Und eine Frage?", @sentences[2]
  end
  def test_split_on_!
    assert_equal "Ein zweiter Satz!", @sentences[1]
  end

  def test_dont_split_on_countings
    assert_equal "Am 15. Mai 2010 feiere ich die Arbeit.", @sentences[3]
  end
  def test_dont_split_on_special_abbreviation
    assert_equal "Einige Abkürzungen für Mrs. Kniep sind schon eingebaut.", @sentences[4]
    end
  def test_dont_split_on_abbreviation
    assert_equal "Eine Abkürzung z.B. in einem Satz macht u.a. usw. keinen Sinn.", @sentences[5]
  end

  def test_accept_multi_puncuation
    assert_equal "Am Ende des Satzes heißt es warten...", @sentences[6]
    assert_equal "Das wars !!!", @sentences[7]
  end
  def test_special_numbers
    assert_equal "Aber auch Römische Zahlen funktionieren der MXMII. König meint: \"alles wird gut...\".", @sentences[8]
  end

end