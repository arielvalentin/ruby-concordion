module ConcordionConstants

  def concordion_command_attributes
    [ "assertequals", "set", "execute", "verifyrows"].collect {|cmd| "concordion:#{cmd}"}
  end

  def supported?(tagname)
    ['p', 'span'].include?(tagname.downcase)
  end

end
