Pod::Spec.new do |spec|
spec.platform = :ios, "9.0"
spec.name = "LazyData"
spec.version = "0.0.1"
spec.summary = "Lazy Data is a high-level Core Data framework which will facilitate the use of Core Data for multiple tasks."
spec.homepage = "http://www.nsmarcos.com"
spec.authors = { "Marcos Rodriguez" => 'marcos@nsmarcos.com' }
spec.license = { type: 'MIT', file: 'LICENSE' }
spec.requires_arc = true
spec.source = { git: "https://github.com/marcosrdz/lazydata.git", tag: "v#{spec.version}", submodules: true, :commit => "78da987a15ad9eded787ca898f9bac7cb94e2861" }
spec.source_files = "LazyData/**/*.{h,swift}"
spec.exclude_files = 'LazyData/Lazy DataTests/**/*.{h,m,swift}'
end