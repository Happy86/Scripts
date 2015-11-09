# SSH Config and Keys management

1. Create the following folder structure in your ~/.ssh/ folder:
   1. ~/.ssh/config-and-keys/
   2. ~/.ssh/config-and-keys/keys/
   3. ~/.ssh/config-and-keys/config.d/
2. Store all your ssh-keys (public AND private) in ~/.ssh/config-and-keys/keys/
3. Store all your ssh config files in ~/.ssh/config-and-keys/config.d/ (config-work, config-private, ...).
4. Run ./config.d-create-symlinks.sh - it will create the necessary symlinks to your ~/.ssh/ folder.
5. Run ./config.d-gen.sh - it will create your single ~/.ssh/config file SSH can handle.


## config.d-create-symlinks.sh

Create symlinks to the contents of the keys/ folder (~/.ssh/), the config.d-gen.sh script and and the config.d directory; and make sure all files have the right file permissions.

## config.d-gen.sh

Backup old config file and create a new ~/.ssh/config file from (the symlink) ~/.ssh/config.d/* and make sure that the file permissions are correct for the configuration.


