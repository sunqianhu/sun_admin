<template>
  <div class="rich-editor">
    <Toolbar
      :editor="editorRef"
      :defaultConfig="toolBarConfig"
      :mode="mode"
      class="rich-editor__tool-bar"
    />
    <Editor
      v-model="html"
      :defaultConfig="editorConfig"
      :mode="mode"
      @onCreated="setEditRef"
      :style="'height: ' + height + 'px'"
    />
  </div>
</template>

<script setup>
import "@wangeditor/editor/dist/css/style.css"; // 引入 css

import { onBeforeUnmount, ref, shallowRef, watch } from "vue";
import { Editor, Toolbar } from "@wangeditor/editor-for-vue";

const props = defineProps({
  mode: {
    type: String,
    default: "default",
  },
  height: {
    type: Number,
    default: 350,
  },
  toolBarConfig: {
    type: Object,
    default: {},
  },
  editorConfig: {
    type: Object,
    default: {},
  },
});
const html = defineModel({
  type: String,
  default: undefined,
});
const editorRef = shallowRef(); // 编辑器实例，必须用 shallowRef
const mode = props.mode;
const token = localStorage.getItem("token") || "";
const toolBarConfig = Object.assign(
  {},
  {
    //toolBarKeys: ["bold"]
    //excludeKeys: []
  },
  props.editorConfig
);
const editorConfig = Object.assign(
  {},
  {
    placeholder: "请输入...",
    MENU_CONF: {
      uploadImage: {
        server: import.meta.env.VITE_API_PREFIX + "desktop/UploadFile/upload",
        fieldName: "file",
        maxFileSize: 1024 * 1024 * 20,
        headers: {
          token: token,
        },
        meta: {
          module: "rich_editor",
        },
        timeout: 1000 * 15,
        customInsert(response, insertFn) {
          if (response.code != 1) {
            ElMessage({
              message: response.message,
              type: "error",
            });
            return;
          }

          let responseData = response.data;
          insertFn(responseData.url, responseData.name, responseData.url);
        },
      },
      uploadVideo: {
        server: import.meta.env.VITE_API_PREFIX + "desktop/UploadFile/upload",
        fieldName: "file",
        maxFileSize: 1024 * 1024 * 200,
        headers: {
          token: token,
        },
        meta: {
          module: "rich_editor",
        },
        timeout: 1000 * 60,
        customInsert(response, insertFn) {
          if (response.code != 1) {
            ElMessage({
              message: response.message,
              type: "error",
            });
            return;
          }

          let responseData = response.data;
          insertFn(responseData.url, responseData.name, responseData.url);
        },
      },
    },
  },
  props.editorConfig
);

/**
 * 设置编辑器模板引用
 * @param {*} editor
 */
const setEditRef = (editor) => {
  editorRef.value = editor; // 记录 editor 实例，重要！
};

onBeforeUnmount(() => {
  const editor = editorRef.value;
  if (editor == null) return;
  editor.destroy();
});
</script>

<style lang="scss" scoped>
.rich-editor {
  border: 1px solid var(--border-color);
  .rich-editor__tool-bar {
    border-bottom: 1px solid var(--border-color);
  }
}
</style>
