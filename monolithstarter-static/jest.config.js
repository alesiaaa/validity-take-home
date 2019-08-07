module.exports = {
  moduleFileExtensions: ["js"],
  transform: {
    "^.+\\.js$": "babel-jest",
    "^.+\\.(js|jsx)?$": "babel-jest"
  },
  reporters: [
    'default',
    'jest-skipped-reporter'
  ],
  setupFilesAfterEnv: [
    'jest-enzyme',
    './node_modules/jest-enzyme/lib/index.js'
  ],
  testEnvironment: 'enzyme',
  testEnvironmentOptions: {
    enzymeAdapter: 'react16'
  }
};
