import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import { VantResolver } from "@vant/auto-import-resolver";
import dotenv from "dotenv";

// https://vitejs.dev/config/
const viteConfig = ({ mode }) => {
  dotenv.config({ path: ".env." + mode });
  return defineConfig({
    plugins: [
      vue(),
      AutoImport({
        resolvers: [VantResolver()]
      }),
      Components({
        resolvers: [VantResolver()]
      })
    ],
    resolve: {
      alias: {
        "@": fileURLToPath(new URL("./src", import.meta.url))
      }
    },
    server: {
      proxy: {
        "/api": {
          target: process.env.VITE_API_URL,
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, "")
        }
      },
      host: "0.0.0.0",
      port: 5173
    }
  });
};
export default viteConfig;
