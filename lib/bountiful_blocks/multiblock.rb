module BountifulBlocks
  class Multiblock
    def initialize *required_blocks, &block
      @raw = instance_exec(&block)

      missing_blocks = required_blocks.reject { |method_name| given? method_name }

      raise ArgumentError, "Block required for #{missing_blocks.join ', '}" unless missing_blocks.empty?

      given!.freeze
      freeze
    end

    def method_missing(name, *args, **kwargs, &block)
      return super unless args.empty? && kwargs.empty?
      return super if name.end_with? '!', '?', '='

      define_singleton_method name, &block
    end

    def respond_to_missing?(name, *args, **kwargs, &block)
      return super if name.end_with? '!', '?', '='

      true
    end

    def given? name
      singleton_class.method_defined? name
    end

    def given!
      @given = [] unless defined?(@given)

      @given
    end

    def raw!
      @raw
    end
  end
end
