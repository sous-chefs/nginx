# nginx Chef Cookbook

nginx is a Chef cookbook that provides resource-based management for installing and configuring nginx web server. It supports multiple installation methods (distribution packages, official nginx repository, EPEL) and provides unified configuration management similar to Debian's Apache2 scripts.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Bootstrap and Dependencies
- Install Ruby (3.0+): `sudo apt-get update && sudo apt-get install -y ruby ruby-dev build-essential`
- Install required gems (expect conflicts requiring force installation):
  - `echo "y" | sudo gem install bundler cookstyle rspec chefspec --no-doc` (~30 seconds)
  - `sudo gem install chefspec --no-doc --force` (if conflicts occur)
  - `echo "y" | sudo gem install test-kitchen kitchen-docker --no-doc` (~12 seconds)
  - `sudo gem install test-kitchen kitchen-docker --no-doc --force` (if conflicts occur)
  - `sudo gem install kitchen-dokken kitchen-vagrant kitchen-inspec berkshelf --no-doc --force` (~60 seconds)
- Install Docker: Required for integration testing with Test Kitchen
- Add user to docker group: `sudo usermod -aG docker $USER`
- Verify installations: `cookstyle --version`, `kitchen version`
- **IMPORTANT**: Gem installation often has conflicts. Always use `--force` flag and answer 'y' to conflicts.

### Verified Installation Sequence
```bash
# Basic tools (always works)
sudo gem install bundler cookstyle --no-doc

# Core testing gems (expect conflicts)
echo "y" | sudo gem install rspec chefspec --no-doc
sudo gem install chefspec --no-doc --force

# Test Kitchen ecosystem (expect conflicts)  
echo "y" | sudo gem install test-kitchen kitchen-docker --no-doc
sudo gem install test-kitchen kitchen-docker --no-doc --force
sudo gem install kitchen-dokken kitchen-vagrant kitchen-inspec berkshelf --no-doc --force

# Docker setup
sudo usermod -aG docker $USER
```

### Linting and Code Style
- **ALWAYS** run linting before committing: `cookstyle .`
- Lint execution time: ~2 seconds
- Auto-fix linting issues: `cookstyle --autocorrect .`
- Configuration file: `.rubocop.yml` (inherits from cookstyle gem)
- Common issues: Style/RedundantParentheses, Layout/LineContinuationSpacing
- **VERIFIED**: Auto-correction successfully fixes common style issues

### Unit Testing
- Run unit tests: `rspec`
- **CRITICAL**: Unit tests currently have RSpec dependency conflicts that prevent execution
- **ERROR**: `Gem::ConflictError: rspec-support version conflicts` - ChefSpec requires older RSpec versions
- **WORKAROUND**: Focus on cookstyle linting and integration testing for validation
- Unit test location: `spec/unit/` directory
- Test framework: ChefSpec (Chef-specific RSpec extensions)
- **Troubleshooting**: Use `sudo gem install chefspec --no-doc --force` and resolve conflicts manually
- If unit tests work, execution time: ~1 second when dependencies are available
- Spec helper: `spec/spec_helper.rb`
- Unit tests cover: Resource behavior, library methods, configuration generation

### Integration Testing
- Run integration tests: `kitchen test`
- **NEVER CANCEL** integration tests - they take 15-45 minutes per suite depending on platform
- Set timeout to 60+ minutes for integration testing commands
- **PREREQUISITE**: Docker must be running and user added to docker group
- **PREREQUISITE**: All kitchen gems must be installed: `kitchen-dokken`, `kitchen-vagrant`, `kitchen-inspec`
- **COMMON ISSUE**: Verifier loading errors require proper gem installation
- Test configuration: `kitchen.yml` (Vagrant) and `kitchen.dokken.yml` (Docker)
- **Recommended**: Use Docker-based testing: `KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test`
- **Network Required**: Berkshelf dependencies need internet access to Chef Supermarket
- Available test suites:
  - `distro`: Distribution package installation
  - `repo`: Official nginx repository installation  
  - `epel`: EPEL repository installation (RHEL-based only)
  - `distro-nginx-full`: Full nginx with all modules (Ubuntu only)
- Platform coverage: AlmaLinux 8/9, Rocky Linux 8/9, CentOS Stream 9/10, Amazon Linux 2023, Debian 11/12, Ubuntu 22.04/24.04
- Integration tests use InSpec framework to validate:
  - Package installation (`package('nginx').should be_installed`)
  - Service status (`service('nginx').should be_running`)
  - Configuration file presence and syntax
  - Port availability and nginx response

### Dependencies Management
- Dependency file: `Berksfile`
- Install cookbook dependencies: `berks install` (requires berkshelf gem)
- **NETWORK REQUIRED**: Berkshelf needs internet access to https://supermarket.chef.io
- **COMMON ERROR**: `SocketError: No address associated with hostname` indicates network restrictions
- Update dependencies: `berks update`
- Upload to Chef server: `berks upload`
- **VERIFIED TIMING**: `berks install` ~30 seconds when network available
- **NOTE**: Berkshelf installation may require additional Chef infrastructure setup
- **Alternative**: Review Berksfile manually for dependency requirements

## Validation

### Pre-commit Validation
- **REQUIRED**: Always run `cookstyle .` before committing (~2 seconds)
- **VERIFIED**: Use `cookstyle --autocorrect .` to auto-fix common style issues (~1.5 seconds)
- **UNIT TESTS**: Run `rspec` for unit tests (currently broken due to dependency conflicts)
- **WORKAROUND**: Skip unit tests and focus on linting + integration testing when rspec fails
- **RECOMMENDED**: Run integration tests for changed functionality: `kitchen test [suite-name]` (15-45 minutes)
- Pre-commit hooks configuration: `.overcommit.yml`
- **Manual alternative**: If tooling is unavailable, carefully review code changes against style guide

### Integration Testing Scenarios
- **Basic nginx installation**: Verify nginx package is installed and service starts
- **Configuration management**: Test site enable/disable functionality
- **Service management**: Verify nginx service can start, stop, restart, reload
- **Multi-platform compatibility**: Test on different OS families (Debian, RHEL, Amazon)

### Manual Validation
- After resource changes, always test cookbook compilation: `chef-client --local-mode --runlist 'nginx::default'`
- Verify nginx configuration syntax: `nginx -t`
- Test site configuration changes: Enable/disable test sites and verify nginx reloads successfully
- Check service status: `systemctl status nginx`

## Common Tasks

The following are outputs from frequently run commands. Reference them instead of viewing, searching, or running bash commands to save time.

### Repository Structure
```
.
├── README.md                    # Main documentation
├── CONTRIBUTING.md              # Contribution guidelines  
├── TESTING.md                   # Testing documentation
├── CHANGELOG.md                 # Version history
├── metadata.rb                  # Cookbook metadata and dependencies
├── Berksfile                    # Berkshelf dependency management
├── .rubocop.yml                 # Cookstyle/RuboCop configuration
├── .overcommit.yml              # Git hooks configuration
├── kitchen.yml                  # Test Kitchen configuration (Vagrant)
├── kitchen.dokken.yml           # Test Kitchen configuration (Docker)
├── resources/                   # Main cookbook resources
│   ├── install.rb              # nginx_install resource
│   ├── config.rb               # nginx_config resource
│   ├── service.rb              # nginx_service resource
│   └── site.rb                 # nginx_site resource
├── libraries/                   # Helper libraries
│   ├── helpers.rb              # Common helper methods
│   ├── resource.rb             # Resource base classes
│   └── template.rb             # Template helpers
├── templates/                   # Configuration templates
├── spec/                       # Unit tests (ChefSpec)
│   ├── spec_helper.rb          # RSpec configuration
│   └── unit/                   # Unit test files
├── test/                       # Integration tests
│   ├── cookbooks/test/         # Test cookbook
│   └── integration/            # InSpec integration tests
└── documentation/              # Resource documentation
    ├── nginx_install.md        # Installation resource docs
    ├── nginx_config.md         # Configuration resource docs
    ├── nginx_service.md        # Service resource docs
    └── nginx_site.md           # Site resource docs
```

### Core Resources
1. **nginx_install**: Manages nginx installation from various sources (distro, repo, epel)
2. **nginx_config**: Manages main nginx configuration file and directory structure
3. **nginx_service**: Manages nginx system service (start, stop, restart, reload)
4. **nginx_site**: Manages individual site configurations (enable/disable sites)

### Key Configuration Files
- **metadata.rb**: Cookbook version, dependencies, supported platforms
- **Berksfile**: Cookbook dependencies for testing
- **.rubocop.yml**: Inherits cookstyle rules for Ruby/Chef code standards
- **kitchen.yml**: Test Kitchen platforms and test suites configuration

### Common Command Timings
- `cookstyle .`: ~2 seconds (**VERIFIED**)
- `cookstyle --autocorrect .`: ~1.5 seconds (**VERIFIED**)
- `rspec`: **BROKEN** - dependency conflicts prevent execution
- `kitchen version`: ~0.3 seconds (**VERIFIED**)
- `kitchen test distro-ubuntu-2204`: ~25 minutes - **NEVER CANCEL**
- `kitchen test repo-almalinux-9`: ~30 minutes - **NEVER CANCEL**  
- `kitchen converge`: ~10 minutes - **NEVER CANCEL**
- `kitchen verify`: ~5 minutes
- `berks install`: ~30 seconds (**VERIFIED** when network available)
- **BOOTSTRAP TIMING**: Total gem installation ~90 seconds with conflicts
- CI full test suite: ~45 minutes - **NEVER CANCEL**

### Testing Workflow
1. Make changes to resources, libraries, or tests
2. Run `cookstyle .` to check code style (~2 seconds)
3. **SKIP** `rspec` for unit tests (currently broken due to dependency conflicts)
4. Run integration tests for affected functionality: `kitchen test [suite]` (15-45 minutes)
5. Commit changes only after linting passes and integration tests complete

### Troubleshooting
- **ChefSpec dependency issues**: `Gem::ConflictError: rspec-support version conflicts` - Use `sudo gem install chefspec --no-doc --force`
- **Test Kitchen verifier errors**: Install all required gems: `sudo gem install kitchen-dokken kitchen-vagrant kitchen-inspec --no-doc --force`
- **Test Kitchen Docker issues**: Verify Docker service is running and user in docker group: `sudo usermod -aG docker $USER`
- **Platform-specific failures**: Check OS-specific package availability and repository configuration
- **Service start failures**: Verify nginx configuration syntax and file permissions
- **Lint failures**: Run `cookstyle --autocorrect .` to auto-fix correctable issues
- **Gem installation conflicts**: Always use `sudo gem install [gem] --no-doc --force` and answer 'y' to conflicts
- **Ruby/Chef environment**: Consider using Docker containers for consistent testing environment
- **Network restrictions**: Berkshelf requires internet access to https://supermarket.chef.io for dependencies
- **Bootstrap conflicts**: Expect and force-install through gem conflicts during initial setup

## Important Notes
- This cookbook is **resource-based** - use the provided resources in wrapper cookbooks
- **NEVER CANCEL** long-running operations (integration tests, CI builds)
- Always test on multiple platforms when making installation or service changes
- Configuration templates use ERB templating engine
- Site management follows Apache2-style available/enabled pattern
- Service resource includes configuration validation before reload/restart operations