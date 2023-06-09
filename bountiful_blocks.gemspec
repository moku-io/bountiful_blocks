require_relative 'lib/bountiful_blocks/version'

Gem::Specification.new do |spec|
  spec.name = 'bountiful_blocks'
  spec.version = BountifulBlocks::VERSION
  spec.authors = ['Moku S.r.l.', 'Riccardo Agatea']
  spec.email = ['info@moku.io']
  spec.license = 'MIT'

  spec.summary = 'A simple and idiomatic way to pass multiple blocks to a method.'
  spec.description = 'A simple and idiomatic way to pass multiple blocks to a method.'
  spec.homepage = 'https://github.com/moku-io/bountiful_blocks'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/moku-io/bountiful_blocks'
  spec.metadata['changelog_uri'] = 'https://github.com/moku-io/bountiful_blocks/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir __dir__ do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
