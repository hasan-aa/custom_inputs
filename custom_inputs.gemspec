lib = File.expand_path("../lib", __FILE__)
app = File.expand_path("../app", __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$LOAD_PATH.unshift(app) unless $LOAD_PATH.include?(app)
require "custom_inputs/version"

Gem::Specification.new do |spec|
  spec.name = "custom_inputs"
  spec.version = CustomInputs::VERSION
  spec.authors = ["Hasan Ali Ayar"]
  spec.email = ["hasan.a.ayar@gmail.com"]

  spec.summary = `Custom form input fields for active admin + formtastic.

Demo app: https://custom-inputs-demo.herokuapp.com/admin
Demo user: admin@example.com / password

`
  spec.description = `I've been using Active Admin for developing admin panels for my clients.
There are number of custom input components accumulated along the way.

I've decided to make a gem and share all these custom input components that I think may be very useful.

These inputs are optimised for Arctic Admin theme.
If you are using any other theme you can ignore the css files of this gem and implement your own css.

Note: Although these inputs are being actively used in a production app you should use them at your own risk.
`
  spec.homepage = "https://github.com/hasan-aa/custom_inputs"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/hasan-aa/custom_inputs"
    # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features|examples)/})}
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) {|f| File.basename(f)}
  spec.require_paths = ["lib", "app"]

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
