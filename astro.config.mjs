// @ts-check
import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [tailwindcss()],
    preview:{
      host: '0.0.0.0',
      port: 4321,
      allowedHosts:['bell-x.ru']
    },
  
  }
});