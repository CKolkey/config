module ObjectHelpers
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (methods - Object.instance_methods).sort
    # methods = [
    #   (obj.methods - obj.class.superclass.instance_methods),
    #   (obj.methods - Object.methods)
    # ].flatten.uniq.sort
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
end

Object.prepend(ObjectHelpers)

class Class
  public :include

  # Show only this class class methods
  def class_methods
    (methods - Class.instance_methods - Object.methods).sort
  end

  # Show instance and class methods
  def defined_methods
    methods = {}

    methods[:instance] = new.local_methods
    methods[:class] = class_methods

    methods
  end
end

# Class.include(ClassHelpers)
