# Bin Directory

Executable commands for Claude Code Communication project.

## Commands

- **agent-send**: Send messages between team agents
- **setup**: Initial project setup
- **project-init**: Create new empty project with standard structure

## Usage

Add this directory to your PATH for easy access:

```bash
export PATH="$PATH:$(pwd)/bin"
```

Or run directly:

```bash
./bin/agent-send boss1 "Hello"
./bin/setup
```