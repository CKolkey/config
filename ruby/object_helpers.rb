module ObjectHelpers
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end

  def local_caller
    caller.grep(File.expand_path("."))
  end

  def locals(their_binding)
    local_names = their_binding.local_variables
    local_names.to_h { |n| [n, their_binding.local_variable_get(n)] }
  end

  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = is_a?(Class) ? name : self.class.name
      method = [klass, method].compact.join("#")
    end
    system "ri", method.to_s
  end

  def q
    return unless caller.last.include?("irb")

    exit 1
  end
end

Object.prepend(ObjectHelpers)
