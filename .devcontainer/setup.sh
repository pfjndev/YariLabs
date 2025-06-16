#!/bin/bash

set -e

echo "🚀 Setting up Ruby on Rails development environment..."

# Update system packages
echo "📦 Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y

# Install essential development tools
echo "🔧 Installing essential development tools..."
sudo apt-get install -y \
  build-essential \
  libssl-dev \
  libreadline-dev \
  zlib1g-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libffi-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libgdbm-dev \
  libgdbm-compat-dev \
  libdb-dev \
  uuid-dev \
  curl \
  wget \
  gnupg2 \
  software-properties-common \
  apt-transport-https \
  ca-certificates \
  lsb-release

# Install mise-en-place (rtx)
echo "🎯 Installing mise-en-place for version management..."
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

# Make mise available in current session
export PATH="$HOME/.local/bin:$PATH"
eval "$(~/.local/bin/mise activate bash)"

# Create mise configuration
echo "⚙️ Creating mise configuration..."
cat > ~/.config/mise/config.toml << 'EOF'
[tools]
ruby = "latest"
node = "lts"
python = "latest"

[env]
RAILS_ENV = "development"
RACK_ENV = "development"
EDITOR = "code"

[aliases]
r = "ruby"
ra = "rails"
be = "bundle exec"
EOF

# Install Ruby using mise
echo "💎 Installing latest Ruby version..."
~/.local/bin/mise install ruby@latest
~/.local/bin/mise use ruby@latest

# Install Node.js using mise
echo "📦 Installing Node.js LTS..."
~/.local/bin/mise install node@lts
~/.local/bin/mise use node@lts

# Install Python using mise
echo "🐍 Installing latest Python..."
~/.local/bin/mise install python@latest
~/.local/bin/mise use python@latest

# Install global Ruby gems
echo "💎 Installing essential Ruby gems..."
gem update --system
gem install \
  rails \
  bundler \
  rubocop \
  rubocop-rails \
  rubocop-performance \
  rubocop-rspec \
  rspec \
  pry \
  pry-byebug \
  dotenv \
  foreman \
  mailcatcher \
  solargraph

# Install global Node.js packages
echo "📦 Installing essential Node.js packages..."
npm install -g \
  yarn \
  typescript \
  @tailwindcss/cli \
  prettier \
  eslint

# Install PostgreSQL
echo "🐘 Installing PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib libpq-dev
sudo service postgresql start
sudo -u postgres createuser -s vscode || true

# Install Redis
echo "🔴 Installing Redis..."
sudo apt-get install -y redis-server
sudo service redis-server start

# Configure Git (if not already configured)
echo "🔧 Configuring Git settings..."
if [ -z "$(git config --global user.name)" ]; then
  echo "Please configure your Git settings manually:"
  echo "  git config --global user.name 'Your Name'"
  echo "  git config --global user.email 'your.email@example.com'"
fi

# Create useful aliases
echo "⚡ Setting up useful aliases..."
cat >> ~/.zshrc << 'EOF'

# Ruby on Rails aliases
alias be="bundle exec"
alias ber="bundle exec rails"
alias bes="bundle exec rspec"
alias bec="bundle exec rails console"
alias bet="bundle exec rails test"
alias rs="rails server"
alias rc="rails console"
alias rg="rails generate"
alias rd="rails destroy"
alias rm="rails db:migrate"
alias rr="rails db:rollback"
alias rds="rails db:seed"
alias rdc="rails db:create"
alias rdd="rails db:drop"
alias rdr="rails db:reset"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"

# Docker aliases
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcb="docker-compose build"
alias dcl="docker-compose logs"

# Mise aliases
alias mr="mise reshim"
alias ml="mise list"
alias mi="mise install"
alias mu="mise use"
EOF

# Create a Rails application template directory
echo "📁 Creating Rails templates directory..."
mkdir -p ~/rails-templates

# Create a sample Rails application template
cat > ~/rails-templates/api_template.rb << 'EOF'
# Rails API Template

# Add gems
gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

gem_group :development do
  gem 'annotate'
  gem 'bullet'
  gem 'letter_opener'
end

# Run bundle install
run 'bundle install'

# Generate RSpec configuration
generate 'rspec:install'

# Create basic directories
run 'mkdir -p app/services'
run 'mkdir -p app/queries'
run 'mkdir -p app/serializers'

# Initialize git
git :init
git add: '.'
git commit: '-m "Initial commit"'
EOF

# Install helpful VS Code settings
echo "⚙️ Setting up VS Code workspace settings..."
mkdir -p .vscode
cat > .vscode/settings.json << 'EOF'
{
  "ruby.lsp.enabledFeatures": {
    "codeActions": true,
    "diagnostics": true,
    "documentHighlights": true,
    "documentLink": true,
    "documentSymbols": true,
    "foldingRanges": true,
    "formatting": true,
    "hover": true,
    "inlayHint": true,
    "onTypeFormatting": true,
    "selectionRanges": true,
    "semanticHighlighting": true,
    "completion": true,
    "codeLens": true,
    "definition": true,
    "workspaceSymbol": true,
    "signatureHelp": true,
    "typeHierarchy": true
  },
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "[ruby]": {
    "editor.defaultFormatter": "Shopify.ruby-lsp"
  },
  "files.associations": {
    "*.rb": "ruby",
    "*.rake": "ruby",
    "Gemfile": "ruby",
    "Rakefile": "ruby"
  }
}
EOF

# Create launch configurations for debugging
cat > .vscode/launch.json << 'EOF'
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "rdbg",
      "name": "Debug current file with rdbg",
      "request": "launch",
      "script": "${file}",
      "args": [],
      "askParameters": true
    },
    {
      "type": "rdbg",
      "name": "Attach with rdbg",
      "request": "attach"
    }
  ]
}
EOF

# Create helpful tasks
cat > .vscode/tasks.json << 'EOF'
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Rails Server",
      "type": "shell",
      "command": "bundle exec rails server",
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "new"
      },
      "isBackground": true,
      "problemMatcher": []
    },
    {
      "label": "Rails Console",
      "type": "shell",
      "command": "bundle exec rails console",
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": true,
        "panel": "new"
      }
    },
    {
      "label": "Run RSpec",
      "type": "shell",
      "command": "bundle exec rspec",
      "group": "test",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "new"
      }
    },
    {
      "label": "Run Rubocop",
      "type": "shell",
      "command": "bundle exec rubocop",
      "group": "test",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "new"
      }
    }
  ]
}
EOF

echo "✅ Development environment setup complete!"
echo ""
echo "🎉 Your Ruby on Rails Codespace is ready!"
echo ""
echo "📋 What's installed:"
echo "   • Latest Ruby (managed by mise)"
echo "   • Latest Rails gem"
echo "   • Node.js LTS (managed by mise)"
echo "   • PostgreSQL"
echo "   • Redis"
echo "   • Essential Ruby gems (bundler, rubocop, rspec, etc.)"
echo "   • VS Code extensions for Ruby development"
echo ""
echo "🚀 Quick start commands:"
echo "   • Create new Rails app: rails new myapp --api --database=postgresql"
echo "   • Start Rails server: rails server (or 'rs' alias)"
echo "   • Run tests: bundle exec rspec (or 'bes' alias)"
echo "   • Open Rails console: rails console (or 'rc' alias)"
echo ""
echo "🔧 Useful aliases available:"
echo "   • be = bundle exec"
echo "   • rs = rails server"
echo "   • rc = rails console"
echo "   • And many more! Check ~/.zshrc"
echo ""
echo "Happy coding! 🎯"
