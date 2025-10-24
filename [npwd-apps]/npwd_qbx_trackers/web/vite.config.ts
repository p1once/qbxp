import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import federation from '@originjs/vite-plugin-federation';

const resourceName = 'npwd_qbx_trackers';

export default defineConfig({
  base: './',
  plugins: [
    react(),
    federation({
      name: resourceName,
      filename: 'remoteEntry.js',
      exposes: {
        './config': './npwd.config.ts',
      },
      shared: {
        // Allow NPWD to provide its bundled React without version conflicts
        react: ({ singleton: true, requiredVersion: false } as any),
        'react-dom': ({ singleton: true, requiredVersion: false } as any),
      },
    } as any),
  ],
  build: {
    outDir: 'dist',
    target: 'esnext',
    modulePreload: false,
    cssCodeSplit: false,
    emptyOutDir: true,
  },
  server: {
    host: true,
    port: 3000,
  },
});
