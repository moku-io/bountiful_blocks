module BountifulBlocks
  class Multiblock
    def initialize &block
      instance_exec(&block)
    end

    def method_missing(name, *args, **kwargs, &block)
      super unless args.empty? && kwargs.empty?
      super if name.end_with? '!', '?', '='

      define_singleton_method name, &block
    end

    def respond_to_missing?(name, *args, **kwargs, &block)
      super unless args.empty? && kwargs.empty?
      super if name.end_with? '!', '?', '='

      true
    end
  end
end
