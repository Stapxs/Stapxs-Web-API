module.exports = {
    parser: '@typescript-eslint/parser',
    parserOptions: {
        project: 'tsconfig.json',
        tsconfigRootDir: __dirname,
        sourceType: 'module',
    },
    plugins: ['@typescript-eslint/eslint-plugin'],
    extends: [
        'plugin:@typescript-eslint/recommended',
    ],
    root: true,
    env: {
        node: true,
        jest: true,
    },
    ignorePatterns: ['.eslintrc.js'],
    rules: {
        // 缩进
        'indent': ['error', 4],
        // 允许使用 any
        '@typescript-eslint/no-explicit-any': 'off',
        // debugger
        'no-debugger': 'warn',
        // console
        'no-console': 'warn',
        // 优先使用箭头函数
        'prefer-arrow-callback': 'warn',
        // 引号
        'quotes': ['warn', 'single'],
        // 三元表达式
        'multiline-ternary': ['warn', 'never'],
        '@typescript-eslint/interface-name-prefix': 'off',
        '@typescript-eslint/explicit-function-return-type': 'off',
        '@typescript-eslint/explicit-module-boundary-types': 'off',
        '@typescript-eslint/no-explicit-any': 'off',
    },
};
