module ConcordionConstants

  def concordion_command_attributes
    ["assertequals", "set", "execute", "verifyrows", "asserttrue", "assert_image"].collect do
        |cmd| "concordion:#{cmd}"
    end
  end

  def supported?(tagname)
    ['p', 'span', 'b', 'th', 'tr', 'div'].include?(tagname.downcase)
  end

end
