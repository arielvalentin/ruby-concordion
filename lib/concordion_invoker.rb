require 'loader_helper'
require 'concordion_utility'

class ConcordionInvoker
  include LoaderHelper
  include ConcordionUtility
  
  def initialize(conc)
    @concordion = conc
  end

  def try_to_dereference(cpr)
    rv = nil
    begin
      rv = @concordion.dereference(cpr.system_under_test)
    rescue NoMethodError => e
      method = method_from_no_method_error(e)

      rv = dereference_error_message(e)
    end
    rv
  end
  
  def dereference_error_message(e)
    rv = "["
    clazz = e.to_s.split(":")[1]
    if clazz == 'NilClass'
      rv += "No more rows"
    else
      rv += " on #{clazz} but was not found"
    end
    rv += "]"
  end
  
  
  def invoke_sut(cpr, test_context)
    sut_rv = nil
    if cpr.needs_dereference?
      sut_rv = try_to_dereference(cpr)
    else 

      sut_rv = try_to_invoke_sut(cpr,test_context)
    end
    
    sut_rv
  end
  
  
  def try_to_invoke_sut(cpr, test_context)
    sut_rv = nil
    begin
      
        conc_method = concordion_method_name(cpr.system_under_test)
        arg_values = []
        if has_arguments?(cpr.system_under_test)
          arg_vars = concordion_arguments(cpr.system_under_test)
          arg_values = arg_vars.collect {|var| 
             if var == '#TEXT'
              escape_single_quotes(cpr.content)
            else
              @concordion.get_variable(var) 
            end
          }
        end
    
        args = arg_values.join(",")
       sut_rv = test_context.send(conc_method, *arg_values)  
    rescue NoMethodError => e
      
      if e.to_s =~ /nil:NilClass/
        sut_rv = "[Parse failed for: #{cpr}]"
      else
        method = method_from_no_method_error(e)
        clazz = class_from_no_method_error(e)
        sut_rv = "[Missing method '#{method}' in fixture #{clazz} ]"
      end
    end
    sut_rv
  end

  def method_from_no_method_error(e)
    except_str_from(e).split("`")[1].split("'")[0]
  end
  
  def except_str_from(e)
    e.exception.to_s
  end
  
  def class_from_no_method_error(e)
    except_str_from(e).split("<")[1].split(":")[0]
  end
  
  def invoke_concordion(cpr, sut_rv)
    cmd = commands[cpr.concordion_command]
    if cpr.is_assert_image_command?
      cmd.call(sut_rv, cpr.image_location)
    elsif cpr.is_verify_command?
      cmd.call(sut_rv, cpr.num_results_expected)
    else
      cmd.call(sut_rv, cpr.content)
    end
    
  end


  def commands
    cmds = {}
    cmds["assertequals"] = Proc.new { |a, b| { :result => a == b, :actual => a, :expected => b } }
    cmds["execute"] = Proc.new { |a,b| {:result => true, :actual => a, :expected => b } }
    cmds["verifyrows"] = Proc.new { |a,b| { :result => a.size == b, :actual => a.size, :expected => b } }
    cmds["asserttrue"] = Proc.new { |a, b| { :result => a, :actual => a,  :expected => true } }
    cmds["assert_image"] = Proc.new { |actual_data, expected_image_url| 
      expected_data = File.read(path_for(expected_image_url))
      { :result => actual_data == expected_data, :actual => "[Image data of size #{actual_data.size} omitted]",  :expected => "[Expected to match #{expected_image_url}]" } 
    }
    cmds
  end


end
