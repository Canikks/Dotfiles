# TODO List for Dotfiles

## Configuration Improvements

- [ ] **Documentation**: Add more detailed comments to configuration files explaining the purpose of each section
- [ ] **Modularization**: Consider breaking down larger configuration files into smaller, more focused modules
- [ ] **Consistency**: Standardize formatting and structure across all configuration files
- [ ] **Backup**: Set up proper backup strategy for important configurations

## Missing Configurations

- [ ] **Zsh Configuration**: The zsh.nix import is commented out in home.nix - consider documenting why it's commented out
- [ ] **Kitty Terminal**: The kitty.nix import is commented out - consider documenting why it's commented out
- [ ] **Rio Terminal**: The rio.nix import is commented out - consider documenting why it's commented out
- [ ] **Television**: The television.nix import is commented out - consider documenting why it's commented out
- [ ] **Nix Search TV**: The nix-search-tv.nix import is commented out - consider documenting why it's commented out

## Security

- [ ] **Secrets Management**: Uncomment and properly configure sops-nix for secrets management
- [ ] **Age Key**: Set up age encryption key for secrets as referenced in commented configuration
- [ ] **API Keys**: Securely manage API keys (like openrouter_api_key) using sops

## Performance

- [ ] **Nix Build Optimization**: Review and optimize nix configuration for faster builds
- [ ] **Caching**: Set up proper caching for frequently used packages
- [ ] **Garbage Collection**: Configure automatic garbage collection for nix store

## Testing

- [ ] **Configuration Validation**: Add pre-commit hooks to validate nix configurations
- [ ] **Flake Check**: Ensure flake.nix passes all checks
- [ ] **Nixpkgs Update**: Regularly update nixpkgs inputs and test compatibility

## Cleanup

- [ ] **Unused Files**: Remove any unused configuration files or commented-out configurations
- [ ] **Deprecated Packages**: Check for and remove deprecated packages
- [ ] **Orphaned Configs**: Identify and remove configuration files that are no longer imported

## Future Enhancements

- [ ] **Multiple Hosts**: Add configurations for additional hosts if needed
- [ ] **Container Support**: Add configuration for containerized environments
- [ ] **CI/CD Pipeline**: Set up continuous integration for configuration testing
- [ ] **Documentation Site**: Create a more comprehensive documentation site for the configurations

## Known Issues

- [ ] **Hardware Configuration**: Review hardware-configuration.nix for any needed updates
- [ ] **Flake Compatibility**: Ensure all flake inputs are compatible with current nixpkgs version
- [ ] **Module Conflicts**: Check for any potential conflicts between imported modules