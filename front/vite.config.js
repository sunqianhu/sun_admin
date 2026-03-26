import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import vueDevTools from "vite-plugin-vue-devtools";
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import { ElementPlusResolver } from "unplugin-vue-components/resolvers";
import dotenv from "dotenv";

// https://vite.dev/config/
const viteConfig = ({ mode }) => {
  dotenv.config({ path: ".env." + mode });
  return defineConfig({
    base: process.env.VITE_BASE,
    build: {
      outDir: process.env.VITE_BUILD_OUTDIR,
    },
    plugins: [
      vue(),
      vueDevTools(),
      AutoImport({
        resolvers: [ElementPlusResolver({ importStyle: false })],
      }),
      Components({
        directoryAsNamespace: true,
        resolvers: [ElementPlusResolver({ importStyle: false })],
      }),
    ],
    resolve: {
      alias: {
        "@": fileURLToPath(new URL("./src", import.meta.url)),
      },
    },
    server: {
      proxy: {
        [process.env.VITE_PROXY_PREFIX]: {
          target: process.env.VITE_PROXY_TARGET,
          changeOrigin: true,
          rewrite: (path) =>
            path.replace(new RegExp(`^${process.env.VITE_PROXY_PREFIX}`), ""),
        },
      },
      host: "0.0.0.0",
      port: 5179,
    },
  });
};
export default viteConfig;
