import includePaths from 'rollup-plugin-includepaths';


const BUNDLE = process.env.BUNDLE === 'true'
const ESM = process.env.ESM === 'true'

const fileDest = `blacklight-gallery${ESM ? '.esm' : ''}`
const external = [
  'blacklight-frontend'
]
const globals = {
  'blacklight-frontend': 'Blacklight'
}

let includePathOptions = {
  include: {},
  paths: ['app/javascript', 'vendor/assets/javascripts'],
  external: [],
  extensions: ['.js']
};

const rollupConfig = {
  input: 'app/javascript/blacklight-gallery/index.js',
  output: {
    file: `app/assets/javascripts/blacklight_gallery/${fileDest}.js`,
    format: ESM ? 'es' : 'umd',
    globals,
    generatedCode: { preset: 'es2015' },
    name: ESM ? undefined : 'BlacklightGallery'
  },
  external,
  plugins: [includePaths(includePathOptions)]
}

export default rollupConfig
