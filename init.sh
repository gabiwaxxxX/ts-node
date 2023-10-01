reate a TypeScript and Node.js workspace

# Check if Node and npm are installed
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
    echo "Node.js and npm are required. Please install them before proceeding."
    exit 1
fi


# Initialize a package.json with defaults
npm init -y

# Install TypeScript as a dev dependency
npm install typescript --save-dev

# Install ambient Node.js types for TypeScript
npm install @types/node --save-dev

# Create a tsconfig.json with specified options
npx tsc --init --rootDir src --outDir build \
--esModuleInterop --resolveJsonModule --lib es6 \
--module commonjs --allowJs true --noImplicitAny true

# Create a source folder and an initial TypeScript file
mkdir src
touch src/index.ts
echo 'console.log("Hello world!");' > src/index.ts

# Install development tools for hot-reloading and building
npm install --save-dev ts-node nodemon rimraf

# Create nodemon.json configuration
echo '{
  "watch": ["src"],
  "ext": ".ts,.js",
  "ignore": [],
  "exec": "npx ts-node ./src/index.ts"
}' > nodemon.json

# Add scripts to package.json
npm set-script start:dev "npx nodemon"
npm set-script build "rimraf ./build && tsc"
npm set-script start "npm run build && node build/index.js"

# Display setup completion message
echo "TypeScript and Node.js workspace setup complete."
echo "You can start development using 'npm run start:dev'."
echo "To build for production, use 'npm run build' and then 'npm start'."

