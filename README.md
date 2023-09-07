# BountifulBlocks

A simple and idiomatic way to pass multiple blocks to a method. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bountiful_blocks', '~> 1.0'
```

And then execute:

```bash
$ bundle
```

Or you can install the gem on its own:

```bash
gem install bountiful_blocks
```

## Usage

Bountiful Blocks allows you to pass multiple arbitrary blocks to a method:

```ruby
def deliver message, &block
  mb = Multiblock(&block)
  
  ...
  
  if response.success?
    mb.on_success response.body
  else
    mb.on_error response.code
  end
end

deliver('Hello World!') do
  on_success do |body|
    puts body
  end
  
  on_error do |code|
    raise ClientError, code
  end
end
```

`Kernel#Multiblock` is a simple wrapper for `BountifulBlocks::Multiblock.new`.

You can provide names for required blocks, which will be checked on creation of the multiblock:

```ruby
def deliver message, &block
  mb = Multiblock(:on_success, :on_error, &block)
  
  ...
  
  if response.success?
    mb.on_success response.body
  else
    mb.on_error response.code
  end
end

deliver('Hello World!') do
  on_success do |body|
    puts body
  end
end

# => Block required for on_error (ArgumentError)
```

Alternatively, you can check whether a block with a given name was provided with `Multiblock#given?`:

```ruby
def deliver message, &block
  mb = Multiblock(:on_success, &block)
  
  ...
  
  if response.success?
    mb.on_success response.body
  elsif mb.given? :on_error
    mb.on_error response.code
  else
    'Fallback'
  end
end
```

### Names

Block names follow the same rules as method names, with the exception that they can't end in `!`, `?`, or `=`.

### Utility methods

To avoid conflicts, all utility method names will end in either `!`, `?`, or `=`.

- `raw!` returns the value returned by the block, which can be useful to allow a block to work both as a regular block and a multiblock.
- `given?(name)` returns `true` if a block named `name` was provided.
- `given!` returns the names of all the provided blocks.
- `call_all!` returns a Hash that maps all block names to their results. Notice that since multiblocks are frozen, `call_all!` can't cache the Hash and must create a new one on every invocation.

## Version numbers

BountifulBlocks loosely follows [Semantic Versioning](https://semver.org/), with a hard guarantee that breaking changes to the public API will always coincide with an increase to the `MAJOR` number.

Version numbers are in three parts: `MAJOR.MINOR.PATCH`.

- Breaking changes to the public API increment the `MAJOR`. There may also be changes that would otherwise increase the `MINOR` or the `PATCH`.
- Additions, deprecations, and "big" non breaking changes to the public API increment the `MINOR`. There may also be changes that would otherwise increase the `PATCH`.
- Bug fixes and "small" non breaking changes to the public API increment the `PATCH`.

Notice that any feature deprecated by a minor release can be expected to be removed by the next major release.

## Changelog

Full list of changes in [CHANGELOG.md](CHANGELOG.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moku-io/bountiful_blocks.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
