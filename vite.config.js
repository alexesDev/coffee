import { defineConfig } from 'vite';
import { resolve } from 'path';
import CoffeeScript from 'coffeescript';

const transformCS = {
  name: 'coffee',
  transform: (src, id) => {
    if (id.endsWith('.coffee')) {
      const { js, sourceMap } = CoffeeScript.compile(src, { sourceMap: 'on' });
      return { code: js, sourceMap };
    }
  },
};

export default defineConfig({
  plugins: [transformCS],
  build: {
    rollupOptions: {
      input: {
        main: resolve(__dirname, 'index.html'),
        stars: resolve(__dirname, 'stars/index.html'),
      }
    }
  },
});
