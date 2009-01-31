require 'loader_helper'

class ConcordionInvoker
  include LoaderHelper
  def initialize(conc)
    @concordion = conc
    @builder = conc.invocation_builder
  end

  def try_to_dereference(cpr)
    rv = nil
    begin
      rv = @concordion.dereference(cpr.system_under_test)
    rescue NoMethodError => e
      method = method_from_no_method_error(e)

      
      rv = "[#{method} called"
      clazz = e.to_s.split(":")[1]
      if clazz == 'NilClass'
        rv += " but there was no testable entity to receive it"
      else
        rv += " on #{clazz} but was not found"
      end
      rv += "]"
    end
    rv
  end
  
  def invoke_sut(cpr, test_context)
    sut_rv = nil
    if cpr.needs_dereference?
      sut_rv = try_to_dereference(cpr)
    else 
      invocation_str = try_to_build_invocation_str(cpr)
      if invocation_str.nil?
        sut_rv = "[Parse failed for: #{cpr}]"
      else
        sut_rv = try_to_invoke_sut(invocation_str, test_context)
      end        
    end
    
    sut_rv
  end
  
  def try_to_build_invocation_str(cpr)
    str = nil
    begin
      str = @builder.build_invocation_string(cpr.system_under_test, cpr.content)
    rescue Exception => e
      @last_error = e
    end
    str
  end
  
  def try_to_invoke_sut(invocation_str, test_context)
    sut_rv = nil
    begin
      sut_rv = test_context.instance_eval invocation_str
    rescue NoMethodError => e
      method = method_from_no_method_error(e)
      clazz = class_from_no_method_error(e)
      sut_rv = "[Missing method '#{method}' in fixture #{clazz} ]"
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
    cmds["verifyrows"] = Proc.new { |a,b| 
      { :result => a.size == b, :actual => a.size, :expected => b } }
    cmds["asserttrue"] = Proc.new { |a, b| { :result => a, :actual => a,  :expected => true } }
    cmds["assert_image"] = Proc.new { |actual_data, expected_image_url| 
      expected_data = File.read(path_for(expected_image_url))
      { :result => actual_data == expected_data, :actual => "[Image data of size #{actual_data.size} omitted]",  :expected => "[Expected to match #{expected_image_url}]" } 
    }
    cmds
  end


end
