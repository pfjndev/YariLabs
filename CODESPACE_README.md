# Ruby on Rails Development with GitHub Codespaces

This repository is configured for Ruby on Rails development using GitHub Codespaces with mise-en-place for version management.

## 🚀 Quick Start

### Creating a Codespace

1. **From GitHub.com:**
   - Click the **Code** button on your repository
   - Select the **Codespaces** tab
   - Click **Create codespace on main**

2. **From VS Code:**
   - Install the [GitHub Codespaces extension](https://marketplace.visualstudio.com/items?itemName=GitHub.codespaces)
   - Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
   - Type "Codespaces: Create New Codespace"
   - Select your repository

### First Time Setup

When your Codespace starts for the first time, it will automatically:

- Install the latest Ruby using mise-en-place
- Install Rails and essential Ruby gems
- Install Node.js LTS and essential packages
- Set up PostgreSQL and Redis
- Configure VS Code with Ruby development extensions
- Create helpful aliases and configurations

**This process takes about 5-10 minutes on first run.**

## 🛠 What's Included

### Development Tools
- **Ruby**: Latest version (managed by mise)
- **Rails**: Latest version
- **Node.js**: LTS version (managed by mise)
- **Python**: Latest version (managed by mise)
- **PostgreSQL**: For production-ready database
- **Redis**: For caching and background jobs

### Ruby Gems
- `rails` - Web application framework
- `bundler` - Dependency management
- `rubocop` - Code linting and formatting
- `rspec` - Testing framework
- `pry-byebug` - Debugging
- `foreman` - Process management
- `mailcatcher` - Email testing

### VS Code Extensions
- **Ruby LSP** - Language server for Ruby
- **GitHub Copilot** - AI pair programming
- **Tailwind CSS** - CSS framework support
- **Test Explorer** - Test running interface
- **And many more...**

## 📋 Available Commands & Aliases

### Rails Aliases
```bash
be          # bundle exec
ber         # bundle exec rails
bes         # bundle exec rspec
rs          # rails server
rc          # rails console
rg          # rails generate
rm          # rails db:migrate
rr          # rails db:rollback
rds         # rails db:seed
```

### Git Aliases
```bash
gs          # git status
ga          # git add
gc          # git commit
gp          # git push
gl          # git pull
```

### Mise Commands
```bash
mise list           # List installed versions
mise install ruby   # Install Ruby
mise use ruby@3.3   # Use specific Ruby version
mise current        # Show current versions
```

## 🏗 Creating a New Rails Application

### API-Only Application
```bash
rails new myapp --api --database=postgresql
cd myapp
bundle install
rails db:create
rails server
```

### Full-Stack Application
```bash
rails new myapp --database=postgresql
cd myapp
bundle install
rails db:create
rails server
```

### Using the Included Template
```bash
rails new myapp --api --database=postgresql -m ~/rails-templates/api_template.rb
```

## 🔧 Development Workflow

### Starting Development
1. **Start the Rails server**: `rails server` (accessible at `http://localhost:3000`)
2. **Start PostgreSQL**: `sudo service postgresql start` (if not running)
3. **Start Redis**: `sudo service redis-server start` (if not running)

### Running Tests
```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/user_spec.rb

# Run with coverage
COVERAGE=true bundle exec rspec
```

### Database Operations
```bash
# Create and migrate database
rails db:create db:migrate

# Seed database
rails db:seed

# Reset database
rails db:drop db:create db:migrate db:seed
```

### Code Quality
```bash
# Run Rubocop
bundle exec rubocop

# Auto-correct issues
bundle exec rubocop -A

# Check specific files
bundle exec rubocop app/models/
```

## 🎯 VS Code Tasks

Access these via `Ctrl+Shift+P` > "Tasks: Run Task":

- **Rails Server** - Start the Rails development server
- **Rails Console** - Open Rails console
- **Run RSpec** - Execute all tests
- **Run Rubocop** - Check code style

## 🔄 Managing Versions with Mise

### Install New Versions
```bash
# Install latest Ruby
mise install ruby@latest

# Install specific Ruby version
mise install ruby@3.2.0

# Install latest Rails
gem install rails
```

### Switch Versions
```bash
# Use specific Ruby version for this project
mise use ruby@3.2.0

# Use globally
mise use -g ruby@3.2.0

# Check current versions
mise current
```

## 🌐 Port Forwarding

The following ports are automatically forwarded:

- **3000** - Rails server
- **5432** - PostgreSQL
- **6379** - Redis
- **1025** - MailCatcher

## 🔐 Environment Variables

Common environment variables are pre-configured:

- `RAILS_ENV=development`
- `RACK_ENV=development`
- `EDITOR=code`

Add project-specific variables to `.env` files.

## 🐛 Debugging

### Using VS Code Debugger
1. Install the `debug` gem: `gem install debug`
2. Add breakpoints in VS Code
3. Use the "Debug current file with rdbg" launch configuration

### Using Pry
```ruby
# Add to your code
require 'pry'; binding.pry
```

## 📦 Adding Dependencies

### Ruby Gems
```bash
# Add to Gemfile
gem 'devise'

# Install
bundle install
```

### Node.js Packages
```bash
npm install lodash
# or
yarn add lodash
```

## 🔄 Rebuilding the Container

If you modify the dev container configuration:

1. Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
2. Type "Codespaces: Rebuild Container"
3. Select the command and wait for rebuild

## 💡 Tips & Best Practices

### Performance
- Use `.gitignore` to exclude large directories (`tmp/`, `log/`, `node_modules/`)
- Consider using prebuilds for faster startup times
- Use the included file watcher exclusions

### Settings Sync
- Your VS Code settings automatically sync across all Codespaces
- Extensions and preferences are preserved
- Git configuration may need to be set once

### Cost Optimization
- Stop Codespaces when not in use
- Use the smallest machine type that meets your needs
- Set up auto-deletion for old Codespaces

## 🆘 Troubleshooting

### Common Issues

**Codespace won't start:**
- Check if there are syntax errors in `devcontainer.json`
- View creation logs for detailed error information

**Ruby/Rails not found:**
- Restart your terminal: `source ~/.zshrc`
- Reinstall Ruby: `mise install ruby@latest`

**Database connection errors:**
- Start PostgreSQL: `sudo service postgresql start`
- Create database: `rails db:create`

**Port forwarding not working:**
- Check if the service is running on the expected port
- Verify port forwarding in the Ports tab

### Getting Help
- Check the [GitHub Codespaces documentation](https://docs.github.com/en/codespaces)
- View logs: Command Palette > "Codespaces: View Creation Log"
- Contact support through GitHub

## 📚 Additional Resources

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Ruby on Rails Guides](https://guides.rubyonrails.org/)
- [Mise Documentation](https://mise.jdx.dev/)
- [Ruby LSP Documentation](https://shopify.github.io/ruby-lsp/)
- [Dev Containers Specification](https://containers.dev/)

---

Happy coding! 🚀
