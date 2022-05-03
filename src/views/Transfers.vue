<template>
  <div class="transfers">
    <h1 class="title is-1">Transfers</h1>
    <label
      >Search
      <input v-model="searchTerms" />
    </label>
    <div>
      <button
        class="button is-success my-5 has-text-weight-medium"
        @click="updateTransfers"
      >
        Update transfers
      </button>
      <!-- 5. TransferRow see under components -->
      <transfer-row
        :key="transfer.transactionIdentifier"
        v-for="transfer in searchedTransfers"
        :transfer="transfer"
      />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import TransferRow from "@/components/transferRow.vue";
import transfers from "@/assets/data";
import { Transaction } from "@/types/types";

@Component({
  name: "Transfers",
  components: { TransferRow },
})
export default class Transfers extends Vue {
  searchTerms = "";
  transfers = transfers;

  // Removed eslint-disable clause and added explicit return type instead
  get searchedTransfers(): Transaction[] {
    if (this.searchTerms) {
      // 4.1 Make the transfer list searchable by "recordDate"
      return this.transfers.filter(
        (transfer) =>
          transfer.type
            .toLowerCase()
            .includes(this.searchTerms.toLowerCase()) ||
          transfer.recordDate?.includes(this.searchTerms)
      );
    }
    return this.transfers;
  }

  updateTransfers(): void {
    // 6 Fix the update transfers button
    // 6.1 The problem was that Vue didn't know when the contents of the array have changed. To fix
    //     it, we created a new array, and copied over the transfers from the previous array. The
    //     original forEach function doesn't create a new array. So we use the map function to
    //     create a new array. We have to re-assign it to this.transfers.
    this.transfers[0] = {
      splitFactor: null,
      exDate: null,
      amount: 10000,
      companyId: "568fa387-43d1-499a-bba2-25089f5a881a",
      notes: null,
      pricePerShare: null,
      recordDate: "2021-07-01",
      securityClassId: "ab983cfe-a932-4e25-98ea-f5928a839fe1",
      securityClass: { name: "Common" },
      state: "OLD",
      toSecurityHolderId: "dd971e7f-386b-45dd-93e1-666fbeed0a55",
      toSecurityHolder: {
        fullName: "Jeff Dunlap",
        type: "PERSON",
      },
      transactionIdentifier: "41095fdb-6b52-4257-aef8-dc523d782e53",
      positionWithinDay: 3,
      type: "ISSUE_STOCK",
    };

    this.transfers = this.transfers.map((transfer) => ({
      ...transfer,
      forgottenProperty: `Important data: ${(Math.random() * 100000000)
        .toString()
        .slice(1, 8)}`,
    }));
  }
}
</script>
<style scoped>
.edit-btn {
  margin: 2rem;
}
</style>
