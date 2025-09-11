# nginx Chef Cookbook

nginx is a Chef cookbook that provides resource-based management for installing and configuring nginx web server. It supports multiple installation methods (distribution packages, official nginx repository, EPEL) and provides unified configuration management similar to Debian's Apache2 scripts.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Bootstrap and Dependencies
- Install Ruby (3.0+): `sudo apt-get update && sudo apt-get install -y ruby ruby-dev build-essential`
- Install required gems:
  - `sudo gem install bundler cookstyle rspec chefspec --no-doc`
  - `sudo gem install test-kitchen kitchen-docker --no-doc` (for integration testing)
- Install Docker: Required for integration testing with Test Kitchen
- Verify installations: `cookstyle --version`, `rspec --version`, `kitchen version`

### Linting and Code Style
- **ALWAYS** run linting before committing: `cookstyle .`
- Lint execution time: ~2 seconds
- Auto-fix linting issues: `cookstyle --autocorrect .`
- Configuration file: `.rubocop.yml` (inherits from cookstyle gem)
- Common issues: Style/RedundantParentheses, Layout/LineContinuationSpacing
- **VERIFIED**: Auto-correction successfully fixes common style issues

### Unit Testing
- Run unit tests: `rspec`
- **NOTE**: Unit tests require ChefSpec gem which may have installation challenges in some environments
- Unit test location: `spec/unit/` directory
- Test framework: ChefSpec (Chef-specific RSpec extensions)
- Unit test execution time: ~1 second when dependencies are available
- Spec helper: `spec/spec_helper.rb`
- Unit tests cover: Resource behavior, library methods, configuration generation
- **Troubleshooting**: If ChefSpec is unavailable, focus on integration testing and manual validation

### Integration Testing
- Run integration tests: `kitchen test`
- **NEVER CANCEL** integration tests - they take 15-45 minutes per suite depending on platform
- Set timeout to 60+ minutes for integration testing commands
- Test configuration: `kitchen.yml` (Vagrant) and `kitchen.dokken.yml` (Docker)
- **Recommended**: Use Docker-based testing: `KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test`
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
- Update dependencies: `berks update`
- Upload to Chef server: `berks upload`
- **NOTE**: Berkshelf installation may require additional Chef infrastructure setup
- **Alternative**: Review Berksfile manually for dependency requirements

## Validation

### Pre-commit Validation
- **REQUIRED**: Always run `cookstyle .` before committing
- **VERIFIED**: Use `cookstyle --autocorrect .` to auto-fix common style issues
- **RECOMMENDED**: Run `rspec` for unit tests (if ChefSpec dependencies are available)
- **RECOMMENDED**: Run integration tests for changed functionality: `kitchen test [suite-name]`
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
- `cookstyle .`: ~2 seconds
- `rspec`: ~1 second (with dependencies)
- `kitchen test distro-ubuntu-2204`: ~25 minutes - **NEVER CANCEL**
- `kitchen test repo-almalinux-9`: ~30 minutes - **NEVER CANCEL**  
- `kitchen converge`: ~10 minutes - **NEVER CANCEL**
- `kitchen verify`: ~5 minutes
- `berks install`: ~10 seconds
- CI full test suite: ~45 minutes - **NEVER CANCEL**

### Testing Workflow
1. Make changes to resources, libraries, or tests
2. Run `cookstyle .` to check code style (~2 seconds)
3. Run `rspec` for unit tests (~1 second)
4. Run integration tests for affected functionality: `kitchen test [suite]` (15-45 minutes)
5. Commit changes only after all tests pass

### Troubleshooting
- **ChefSpec dependency issues**: Ensure chefspec gem is properly installed: `sudo gem install chefspec --no-doc`
- **Test Kitchen Docker issues**: Verify Docker service is running and user has permission
- **Platform-specific failures**: Check OS-specific package availability and repository configuration
- **Service start failures**: Verify nginx configuration syntax and file permissions
- **Lint failures**: Run `cookstyle --autocorrect .` to auto-fix correctable issues
- **Gem installation conflicts**: Use `sudo gem install [gem] --no-doc` and answer 'y' to conflicts
- **Ruby/Chef environment**: Consider using Docker containers for consistent testing environment
- **Network restrictions**: Some Chef tooling may require internet access for package downloads

## Important Notes
- This cookbook is **resource-based** - use the provided resources in wrapper cookbooks
- **NEVER CANCEL** long-running operations (integration tests, CI builds)
- Always test on multiple platforms when making installation or service changes
- Configuration templates use ERB templating engine
- Site management follows Apache2-style available/enabled pattern
- Service resource includes configuration validation before reload/restart operations