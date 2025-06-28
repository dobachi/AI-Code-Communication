# Bin Directory

Executable commands for AI-Code-Communication project.

## Commands

- **agent-send**: Send messages between team agents
- **claude-startup**: Automated Claude AI startup with login management
- **gemini-startup**: Automated Gemini AI startup with login management
- **instructions-select**: Switch between instruction modes (challenge/stable/iterative)

## Usage

Add this directory to your PATH for easy access:

```bash
export PATH="$PATH:$(pwd)/bin"
```

Or run directly:

```bash
./bin/agent-send boss1 "Hello"
./bin/project create myproject
./bin/claude-startup myproject # または ./bin/gemini-startup myproject
./bin/instructions-select challenge
```