# Bin Directory

Executable commands for Claude Code Communication project.

## Commands

- **agent-send**: Send messages between team agents
- **setup**: Initial project setup (tmux sessions)
- **claude-startup**: Automated Claude Code startup with login management
- **project-init**: Create new empty project with standard structure
- **instructions-select**: Switch between instruction modes (challenge/stable/iterative)

## Usage

Add this directory to your PATH for easy access:

```bash
export PATH="$PATH:$(pwd)/bin"
```

Or run directly:

```bash
./bin/agent-send boss1 "Hello"
./bin/setup
./bin/claude-startup
./bin/instructions-select challenge
```