import { defineStore } from "pinia";

export const useAvatarStore = defineStore("user_avatar", {
  state: () => ({
    image: "",
  }),
});
