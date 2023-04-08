#!/bin/bash

# Check if a project name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

# Create the project layout
PROJECT_NAME=$1
mkdir -p "$PROJECT_NAME"/{src/{commands,events,interfaces,models,structures,utils},test}

# Create configuration files
touch "$PROJECT_NAME"/{.gitignore,.editorconfig,.eslintrc.json,.prettierrc.json,tsconfig.json,package.json,.env-example}

# Create the main entry point
touch "$PROJECT_NAME"/src/index.ts

# Generate README.md file
cat > "$PROJECT_NAME"/README.md << EOL
# $PROJECT_NAME

A professional Discord bot project created with TypeScript.

## Project Structure

\`\`\`console
$PROJECT_NAME/
│
├── src/
│   ├── commands/
│   ├── events/
│   ├── interfaces/
│   ├── models/
│   ├── structures/
│   ├── utils/
│   └── index.ts
│
├── test/
│
├── .gitignore
├── .editorconfig
├── .eslintrc.json
├── .prettierrc.json
├── tsconfig.json
├── package.json
└── .env
\`\`\`

## Directory and File Explanation

- \`src/\` is the main source directory containing all TypeScript files.
  - \`commands/\` holds the command files for each specific command, grouped by categories.
  - \`events/\` stores event handler files for Discord events.
  - \`interfaces/\` contains TypeScript interfaces for consistent data structures.
  - \`models/\` has data models for your database (if you use one).
  - \`structures/\` stores classes that extend existing Discord.js classes or create new custom structures.
  - \`utils/\` contains utility functions, constants, and other miscellaneous helpers.
  - \`index.ts\` is the main entry point of the bot, responsible for starting and connecting it to Discord.
- \`test/\` contains unit tests and integration tests for your project.
- \`.gitignore\` is a configuration file for Git to ignore specific files and directories when committing.
- \`.editorconfig\` is a configuration file for maintaining consistent coding styles across editors and IDEs.
- \`.eslintrc.json\` is a configuration file for ESLint, a popular linter for enforcing code quality.
- \`.prettierrc.json\` is a configuration file for Prettier, a popular code formatter.
- \`tsconfig.json\` is the TypeScript configuration file to specify compiler options and other settings.
- \`package.json\` is a file containing metadata about the project and its dependencies.

## Getting Started

1. Install Node.js (v16+ is recommended for Discord.js v13+) and npm.
2. Use a package manager like npm or yarn to manage dependencies.
3. Install TypeScript, Discord.js, and other required dependencies using the package manager.
4. Configure your project to use ESLint and Prettier to maintain code quality and consistency.
5. Create a \`.env\` file at the project root for storing sensitive information like the bot token and API keys. Use a package like \`dotenv\` to load environment variables from the \`.env\` file during development.

To start your bot, run \`npm run dev\` during development, or \`npm start\` for production.

## Development Process
1. Clone this repository and navigate to the project directory.
2. Run \`npm install\` to install the required dependencies.
3. Set up your \`.env\` file with the required environment variables, such as \`DISCORD_BOT_TOKEN\`.
4. Implement your bot commands, events, and other features following the project structure.
5. During development, use \`npm run dev\` to start the bot with hot-reloading enabled (using a tool like \`nodemon\`).
6. Write unit tests and integration tests for your project under the \`test/\` directory.
7. When you're ready to deploy, compile the TypeScript files using \`npm run build\` and start the bot using \`npm start\`.

## Contributing

To contribute to this project, follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Make your changes and commit them to your branch.
4. Push your branch to your forked repository.
5. Create a pull request, detailing the changes made and their purpose.

Please ensure that your code follows the style guide and passes all tests before submitting a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
EOL
