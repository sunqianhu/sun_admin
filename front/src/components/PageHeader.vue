<template>
  <div class="page-header">
    <div class="page-header__title"><slot></slot></div>
    <div class="page-header__subtitle" v-if="$slots.subtitle">
      <slot name="subtitle"></slot>
    </div>
    <div class="page-header__action" v-if="$slots.action">
      <slot name="action"></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.page-header {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--margin-sm) var(--margin);
  .page-header__title {
    flex-shrink: 0;
    font-size: var(--font-size-xl);
    font-weight: var(--font-weight-bold);
  }
  .page-header__subtitle {
    flex: 1 1 auto;
    min-width: 0;
    color: var(--font-color-secondary);
    overflow-wrap: break-word;
  }
  .page-header__action {
    flex-shrink: 0;
    margin-left: auto;
  }
  @media (max-width: 768px) {
    .page-header__subtitle {
      order: 1;
      flex-basis: 100%;
    }
  }
}
</style>
