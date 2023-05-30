require_relative 'bountiful_blocks/version'

module BountifulBlocks
  class Error < StandardError; end
end

require_relative 'bountiful_blocks/multiblock'
require_relative 'bountiful_blocks/kernel_patch'
