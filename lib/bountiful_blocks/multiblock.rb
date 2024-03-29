module BountifulBlocks
  class Multiblock
    def initialize *required_blocks, &block
      @raw = instance_exec(&block)

      missing_blocks = required_blocks.reject { |method_name| given? method_name }

      raise ArgumentError, "Block required for #{missing_blocks.join ', '}" unless missing_blocks.empty?

      singleton_class.class_exec do
        undef_method :method_missing
        undef_method :respond_to_missing?
      end

      given!.freeze
      given_blocks!.freeze
      freeze
    end

    def method_missing(name, *args, **kwargs, &block)
      return super unless args.empty? && kwargs.empty?
      return super if name.end_with? '!', '?', '='

      define_singleton_method name, &block
      given! << name
      given_blocks![name] = block

      nil
    end

    def respond_to_missing?(name, *args, **kwargs, &block)
      return super if name.end_with? '!', '?', '='

      true
    end

    def given? name
      given_blocks!.key? name
    end

    def given!
      @given = [] unless defined?(@given)

      @given
    end

    def given_blocks!
      @given_blocks = {} unless defined?(@given_blocks)

      @given_blocks
    end

    def raw!
      @raw
    end

    def call_all!(*args, **kwargs, &block)
      given_blocks!.transform_values { |given_block| given_block.call(*args, **kwargs, &block) }
    end
  end
end
