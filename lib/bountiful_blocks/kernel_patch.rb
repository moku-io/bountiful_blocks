module Kernel
  # rubocop:disable Naming/MethodName
  def Multiblock *args, **kwargs, &block
    BountifulBlocks::Multiblock.new(*args, **kwargs, &block)
  end
  # rubocop:enable Naming/MethodName
end
