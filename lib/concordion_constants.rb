module ConcordionConstants

  def concordion_command_attributes
    ["assertequals", "set", "execute", "verifyrows", "asserttrue"].collect do
        |cmd| "concordion:#{cmd}"
    end
  end

  def supported?(tagname)
    ['p', 'span', 'b', 'th', 'tr', 'div'].include?(tagname.downcase)
  end

end
