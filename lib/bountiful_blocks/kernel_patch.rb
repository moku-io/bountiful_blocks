module Kernel
  # rubocop:disable Naming/MethodName
  def Multiblock &block
    BountifulBlocks::Multiblock.new(&block)
  end
  # rubocop:enable Naming/MethodName
end
