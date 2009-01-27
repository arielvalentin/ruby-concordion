require 'test_helper'
require 'concordion_utility'

class ConcordionUtilityTest < Test::Unit::TestCase
  include ConcordionUtility

  def test_supported
    assert supported?('p')
    assert supported?("p")
    assert supported?("P")
    assert !supported?("R")
  end   

  def test_snakeCase
    assert_equal "bob", snake_case("bob")
    assert_equal "bob", snake_case("Bob")
    assert_equal "camel_case", snake_case("CamelCase")
    assert_equal "camel_case_var", snake_case("camelCaseVar")
  end


  def test_snake_cased_test_name
    assert_equal "bob.html", snake_cased_test_name("bob")
    assert_equal "bob.html", snake_cased_test_name("Bob")
    assert_equal "bob.html", snake_cased_test_name("BobTest")
    assert_equal "bob_case.html", snake_cased_test_name("BobCaseTest")
  end

  def test_snake_cased_goldmaster_name
    assert_equal "bob_goldmaster.html", snake_cased_goldmaster_name("bob")
    assert_equal "bob_goldmaster.html", snake_cased_goldmaster_name("Bob")
    assert_equal "bob_goldmaster.html", snake_cased_goldmaster_name("BobTest")
    assert_equal "bob_case_goldmaster.html", snake_cased_goldmaster_name("BobCaseTest")
  end

  def test_conc_method_name_hard
    assert_equal "greeting=", concordion_method_name("#result = greeting=(#TEXT)")
  end
  
  def test_escapes_single_quotes
    assert_equal "A\\\\'s", escape_single_quotes("A's")
  end
  
  def test_conc_method_name
    assert_equal "invoke", concordion_method_name("invoke()")
    assert_equal "invoke", concordion_method_name("invoke(")
    assert_equal "invoke", concordion_method_name("invoke")
    assert_equal "bleh", concordion_method_name("bleh(foo,bar)")
    assert_equal "bleh", concordion_method_name("bleh  (   foo , bar)")
    assert_equal "foo", concordion_method_name("#baz = foo ( #asdf, #fdsa)")
    assert_equal "greeting=", concordion_method_name("greeting=(#TEXT)")
  end

  def test_conc_var_name
    assert_equal "#result", concordion_variable_name("#result.first()")
    assert_equal "#res", concordion_variable_name(" #res  ")

  end

  def test_has_args
    assert has_arguments?("invoke(#foo,#bar)")
    assert !has_arguments?("invoke()")
  end

  def test_conc_args
    assert_equal [], concordion_arguments("invoke()")
    assert_equal ["#foo","#bar"],  concordion_arguments("bleh(#foo,#bar)")
    assert_equal ["#foo","#bar"], concordion_arguments("bleh ( #foo    ,    #bar  )")
  end

  def test_conc_assignment
    assert_equal "#foo", concordion_assignment("  #foo = getResult() ")
    assert_equal "#for", concordion_assignment("#for=")
  end
  def test_has_assignment
    assert has_assignment?("=")
    assert !has_assignment?("")
  end

  def test_has_property_ref
    assert has_property_reference?("#res.foo")
    assert !has_property_reference?("#res")

  end

  def test_property_ref
    assert_equal "bar", concordion_property_reference("  #foo.bar ")
    assert_equal "bar.baz", concordion_property_reference("#for.bar.baz")

  end

  def test_singular
    assert_equal "bar", singular("bars")
    assert_equal "foo", singular("foo")
  end
end
