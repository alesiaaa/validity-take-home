module.exports = {
  extends: 'eslint-config-react-app',
  root: true,
  settings: {
    react: {
      version: '16.8'
    }
  },
  rules: {
    semi: ['warn', 'always'],
    'no-fallthrough': 'warn',
    'no-undef': 'warn', // !
    'no-unused-vars': ['warn', {'args': 'after-used'}],
    'prefer-const': 'warn',
  }
};
