<<<<<<< HEAD
require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  install_oh_my_zsh
  switch_to_zsh
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.rdoc LICENSE oh-my-zsh]
  files << "oh-my-zsh/custom/plugins/rbates"
  files << "oh-my-zsh/custom/rbates.zsh-theme"
  files.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  elsif file =~ /zshrc$/ # copy zshrc instead of link
    puts "copying ~/.#{file}"
    system %Q{cp "$PWD/#{file}" "$HOME/.#{file}"}
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
=======
require 'yaml'

def bail_on_failure
  exitstatus = $?.exitstatus
  if exitstatus != 0
    err "last command failed with exit status #{exitstatus}"
    exit 1
  end
end

def version
  `git describe`.chomp
end

def rubygems_version
  # RubyGems will barf if we try to pass an intermediate version number
  # like "1.1b2-10-g61a374a", so no choice but to abbreviate it
  `git describe --abbrev=0`.chomp
end

def yellow
  "\033[33m"
end

def red
  "\033[31m"
end

def clear
  "\033[0m"
end

def warn(str)
  puts "#{yellow}warning: #{str}#{clear}"
end

def err(str)
  puts "#{red}error: #{str}#{clear}"
end

def prepare_release_notes
  # extract base release notes from README.txt HISTORY section
  File.open('.release-notes.txt', 'w') do |out|
    lines = File.readlines('README.txt').each { |line| line.chomp! }
    while line = lines.shift do
      next unless line =~ /^HISTORY +\*command-t-history\*$/
      break unless lines.shift == '' &&
                  (line = lines.shift) && line =~ /^\d\.\d/ &&
                  lines.shift == ''
      while line = lines.shift && line != ''
        out.puts line
      end
      break
    end
    out.puts ''
    out.puts '# Please edit the release notes to taste.'
    out.puts '# Blank lines and lines beginning with a hash will be removed.'
    out.puts '# To abort, exit your editor with a non-zero exit status (:cquit in Vim).'
  end

  unless system "$EDITOR .release-notes.txt"
    err "editor exited with non-zero exit status; aborting"
    exit 1
  end

  filtered = read_release_notes
  File.open('.release-notes.txt', 'w') do |out|
    out.print filtered
  end
end

def read_release_notes
  File.readlines('.release-notes.txt').reject do |line|
    line =~ /^(#.*|\s*)$/ # filter comment lines and blank lines
  end.join
end

task :default => :spec

desc 'Print help on preparing a release'
task :help do
  puts <<-END

The general release sequence is:

  rake prerelease
  rake gem
  rake push
  rake upload:all

Note: the upload task depends on the Mechanize gem; and may require a
prior `gem install mechanize`

  END
end

desc 'Run specs'
task :spec do
  system 'bundle exec rspec spec'
  bail_on_failure
end

desc 'Create vimball archive'
task :vimball => :check_tag do
  system 'make'
  bail_on_failure
  FileUtils.cp 'command-t.vba', "command-t-#{version}.vba"
end

desc 'Clean compiled products'
task :clean do
  Dir.chdir 'ruby/command-t' do
    system 'make clean' if File.exists?('Makefile')
    system 'rm -f Makefile'
  end
end

desc 'Clobber all generated files'
task :clobber => :clean do
  system 'make clean'
end

desc 'Compile extension'
task :make do
  Dir.chdir 'ruby/command-t' do
    ruby 'extconf.rb'
    system 'make clean'
    bail_on_failure
    system 'make'
    bail_on_failure
  end
end

desc 'Check that the current HEAD is tagged'
task :check_tag do
  unless system 'git describe --exact-match HEAD 2> /dev/null'
    warn 'current HEAD is not tagged'
  end
end

desc 'Run checks prior to release'
task :prerelease => ['make', 'spec', :vimball, :check_tag]

namespace :upload do
  desc 'Upload current vimball to Amazon S3'
  task :s3 => :vimball do
    sh 'aws --curl-options=--insecure put ' +
      "s3.wincent.com/command-t/releases/command-t-#{version}.vba " +
      "command-t-#{version}.vba"
    sh 'aws --curl-options=--insecure put ' +
      "s3.wincent.com/command-t/releases/command-t-#{version}.vba?acl " +
      '--public'
  end

  desc 'Upload current vimball to www.vim.org'
  task :vim => :vimball do
    prepare_release_notes
    sh "vendor/vimscriptuploader/vimscriptuploader.rb \
            --id 3025 \
            --file command-t-#{version}.vba \
            --message-file .release-notes.txt \
            --version #{version} \
            --config ~/.vim_org.yml \
            .vim_org.yml"
  end

  desc 'Upload current vimball everywhere'
  task :all => [ :s3, :vim ]
end

desc 'Create the ruby gem package'
task :gem => :check_tag do
  sh "gem build command-t.gemspec"
end

desc 'Push gem to Gemcutter ("gem push")'
task :push => :gem do
  sh "gem push command-t-#{rubygems_version}.gem"
>>>>>>> d9741423d8f34e5c89aa8e01c051b0ba2298e286
end
