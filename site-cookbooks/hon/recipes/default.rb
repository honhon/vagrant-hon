log "##### Hello! #####"
%w{zsh git vim emacs tmux screen}.each do |pkg|
    package pkg do
        action :install
    end
end

# ruby (rbenv)
rbenv_ruby "2.2.3" do
    ruby_version "2.2.3"
    global true
end
rbenv_gem "bundler" do
  ruby_version "2.2.3"
end

# for vim
cookbook_file "/home/vagrant/.vimrc" do
    source "vimrc"
    owner "vagrant"
    group "vagrant"
    mode "0644"
end

# for tmux
template "/home/vagrant/.tmux.conf" do
    source "tmux.conf.erb"
    owner "vagrant"
    group "vagrant"
    mode "0644"
end

# for screenrc
bash "screenrc" do
    user  "vagrant"
    group "vagrant"
    cwd "/home/vagrant"
    code <<-EOC
cat << EOF > .screenrc
startup_message off
autodetach on
defscrollback 100000
hardstatus alwayslastline "[%02c] %-w%{=b bw}%n %t%{-}%+w"
EOF
    EOC
end
