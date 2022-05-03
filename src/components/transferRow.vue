<template>
  <!-- 5.2 Used flexbox here because it gives more flexbility in arranging the elements -->
  <div class="is-flex mx-auto mb-3 is-clipped border-grey transfer-card">
    <!-- 5.3 Custom color based on transfer.type -->
    <div
      class="px-1"
      :class="{
        'has-background-danger': transfer.type === 'TRANSFER',
        'has-background-primary':
          transfer.type === 'INCREASE_AUTHORIZED_CAPITAL',
        'has-background-warning': transfer.type === 'ISSUE_STOCK',
      }"
    ></div>
    <!-- 5.4 Left column contains transfer.amount & transfer.recordDate -->
    <div
      class="is-flex is-flex-direction-column is-justify-content-space-between p-5"
    >
      <div>
        <p class="has-text-left is-size-4">{{ transfer.amount }}</p>
      </div>
      <div>
        <p class="is-size-6 has-text-grey-light">{{ transfer.recordDate }}</p>
      </div>
    </div>
    <!-- 5.5 Border line to separate the left & right -->
    <div class="border-grey"></div>
    <!-- 5.6 Right column contains 2 rows -->
    <div
      class="is-flex is-flex-direction-column is-justify-content-space-between is-flex-grow-1 p-5"
    >
      <!-- 5.7 First row contains transfer.type -->
      <div class="mb-5">
        <p class="has-text-right">
          <span
            class="mr-2"
            :class="{
              'has-text-danger': transfer.type === 'TRANSFER',
              'has-text-primary':
                transfer.type === 'INCREASE_AUTHORIZED_CAPITAL',
              'has-text-warning': transfer.type === 'ISSUE_STOCK',
            }"
            >&#8226;</span
          >{{ transfer.type }}
        </p>
      </div>
      <!-- 5.8 Second row contains transfer.state & transfer.securityClass.name &
           transfer.forgottenProperty
      -->
      <div class="is-flex is-justify-content-space-between">
        <div>
          <p class="has-text-left has-text-grey-light">State</p>
          <p class="has-text-left has-text-grey-light">{{ transfer.state }}</p>
        </div>
        <div>
          <p class="has-text-left has-text-grey-light">Class</p>
          <p class="has-text-left has-text-grey-light">
            {{ transfer.securityClass.name }}
          </p>
        </div>
        <div v-if="transfer.forgottenProperty">
          <p class="has-text-left has-text-grey-light">Forgotten Property</p>
          <p class="has-text-left has-text-grey-light">
            {{ transfer.forgottenProperty }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { Component, Prop } from "vue-property-decorator";
import { Transaction } from "@/types/types";

@Component({
  name: "TransferRow",
})
export default class TransferRow extends Vue {
  @Prop({ required: true }) transfer!: Transaction;
}
</script>

<style scoped>
.mx-auto {
  margin-left: auto;
  margin-right: auto;
}
.border-grey {
  border: solid 0.5px lightgrey;
  margin-top: 10px;
  margin-bottom: 10px;
}
.transfer-card {
  width: 580px;
  border-radius: 10px;
}
</style>
