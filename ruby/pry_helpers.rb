module PryHelpers
  def cd(obj)
    pry(obj)
  end
end

include PryHelpers
