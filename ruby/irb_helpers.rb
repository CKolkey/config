# frozen_string_literal: true

module IrbHelpers
  def r(lib)
    require lib
  rescue LoadError
    require_without_bundler(lib, lib)
  end

  def rr(lib)
    require_relative lib
  end

  def clear
    puts `clear`
  end

  # require files from gems that are not in the bundle
  def require_without_bundler(gem, file)
    return require(file) unless defined?(::Bundler)

    if gem_path = Dir.glob("{#{Gem.path.join(',')}}/gems/#{gem}*").first
      $LOAD_PATH.push("#{gem_path}/lib")
      require file
      puts "Required #{gem} but it's not in your bundle!"
    else
      raise LoadError, "Gem #{gem} not found via require_without_bundler"
    end
  end

  def benchmark(n = 1_000_000)
    puts Benchmark.measure { n.times { yield } }
  end
end

IRB::ExtendCommandBundle.include(IrbHelpers)
