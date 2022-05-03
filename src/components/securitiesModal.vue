<template>
  <!-- 3.4 Modal from https://bulma.io/documentation/components/modal/ -->
  <div class="modal" :class="{ 'is-active': isActive }">
    <div class="modal-background"></div>
    <div class="modal-content">
      <div class="modal-card">
        <header class="modal-card-head">
          <p class="modal-card-title">Select Securities</p>
        </header>
        <section class="modal-card-body">
          <!-- 3.5 Checkbox from https://v2.vuejs.org/v2/guide/forms.html#Checkbox -->
          <div class="field">
            <!-- 3.6 Checkbox is included in the label so that if you click on the label, it would
                 select the checkbox too
            -->
            <!-- 3.7 Label = text e.g. Series A -->
            <label
              class="checkbox"
              v-for="security in securities"
              :key="security.id"
            >
              <!-- 3.8 Input = checkbox -->
              <input
                type="checkbox"
                :value="security.id"
                v-model="selectedSecurities"
                @change="$emit('selectSecurities', selectedSecurities)"
              />
              {{ security.name }}
            </label>
          </div>
        </section>
        <footer class="modal-card-foot"></footer>
      </div>
    </div>
    <!-- 3.9 Close modal by clicking close button -->
    <button class="modal-close is-large" @click="$emit('close')"></button>
  </div>
</template>

<script lang="ts">
import { TableData } from "@/types/types";
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";

@Component({
  name: "SecuritiesModal",
})
export default class SecuritiesModal extends Vue {
  @Prop({ required: true }) isActive!: boolean;
  @Prop({ required: true }) securities!: TableData[];
  selectedSecurities: string[] = [];

  mounted(): void {
    // 3.10 Close modal with escape key
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") {
        this.$emit("close");
      }
    });
  }
}
</script>

<style scoped>
/* 3.11 Add spacing between checkboxes */
.checkbox + .checkbox {
  margin-left: 0.5em;
}
</style>
