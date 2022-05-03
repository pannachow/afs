<template>
  <div class="home">
    <h1>This is a table with some important data</h1>
    <!-- 3.1 Added security class -->
    <button
      class="button is-primary my-4 has-text-weight-medium"
      @click="isSecuritiesModalActive = true"
    >
      Select Securities
    </button>
    <!-- 3.2 Modal window that contains a form -->
    <securities-modal
      :isActive="isSecuritiesModalActive"
      :securities="tableData"
      @close="isSecuritiesModalActive = false"
      @selectSecurities="selectSecurities"
    />
    <!-- 1.1 Table row -->
    <div class="table">
      <b-table :data="selectedTableData" :columns="columns"></b-table>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from "vue-property-decorator";
import { TableData } from "@/types/types";
import SecuritiesModal from "@/components/securitiesModal.vue";

@Component({
  name: "Home",
  // 3.3 SecuritiesModal see under components
  components: { SecuritiesModal },
})
export default class Home extends Vue {
  tableData: TableData[] = [];
  selectedTableData: TableData[] = [];
  isSecuritiesModalActive = false;
  columns = [
    {
      label: "Security class",
      field: "name",
      // 1.2 Displays the totals of numeric columns
      subheading: "Total",
    },
    {
      label: "Authorized amount",
      field: "authorizedAmount",
      subheading: "",
      numeric: true,
    },
    {
      label: "Issued amount",
      field: "issuedAmount",
      subheading: "",
      numeric: true,
    },
    {
      label: "Authorized Capital",
      field: "authorizedCapital",
      subheading: "",
      numeric: true,
    },
    {
      label: "Issued capital",
      field: "issuedCapital",
      subheading: "",
      numeric: true,
    },
  ];
  loading = false;

  // Removed eslint-disable clause and added explicit return type instead
  async mounted(): Promise<void> {
    // 2.1 Rewrite using async/await
    try {
      const data = await this.getData();
      this.loading = true;
      this.tableData = data.map((dataItem: TableData) => {
        return {
          ...dataItem,
          randomNumber: Math.random(),
        };
      });
      this.selectedTableData = this.tableData;
      this.calculateTotals(this.selectedTableData);
      this.loading = false;
    } catch (error) {
      console.log(error, "This is not good");
    }
  }

  calculateTotals(data: TableData[]): void {
    // 1.3 Calculate totals as subheadings on columns
    // 1.4 We make a copy of columns and re-assign it so that Vue knows to re-render
    const columns = [...this.columns];
    for (const column of columns) {
      if (column.numeric) {
        // 1.5 Subheading on Buefy b-table column
        column.subheading = data
          .map((row) => row[column.field as keyof TableData] as number)
          .reduce((previous, current) => previous + current, 0)
          .toString();
      }
    }
    this.columns = columns;
  }

  // 3.3 Filtering based on modal selection
  selectSecurities(securities: string[]): void {
    if (securities.length === 0) {
      this.selectedTableData = this.tableData;
    } else {
      this.selectedTableData = this.tableData.filter((row) =>
        securities.includes(row.id)
      );
    }
    this.calculateTotals(this.selectedTableData);
  }

  async getData(): Promise<TableData[]> {
    return [
      {
        // id: "42f2462d-49d0-4e91-8fe1-de2e656b0f06",
        // generated new id because the old id was the same as Series B
        id: "f4adb41c-e964-41de-974c-a03e3da2b207",
        name: "Series A",
        nominalValue: 5,
        authorizedAmount: 1500,
        issuedAmount: 500,
        authorizedCapital: 7550,
        issuedCapital: 2500,
      },
      {
        id: "42f2462d-49d0-4e91-8fe1-de2e656b0f06",
        name: "Series B",
        nominalValue: 10,
        authorizedAmount: 15000,
        issuedAmount: 5000,
        authorizedCapital: 150000,
        issuedCapital: 50000,
      },
      {
        id: "fd78c11b-e3d2-455a-99b0-49907a75c463",
        name: "Series C",
        nominalValue: 1,
        authorizedAmount: 96876,
        issuedAmount: 61760,
        authorizedCapital: 96876,
        issuedCapital: 61760,
      },
      {
        id: "d8654cb0-8986-4fbc-b969-025e514cb934",
        name: "Series D",
        nominalValue: 1,
        authorizedAmount: 10110,
        issuedAmount: 1100,
        authorizedCapital: 10110,
        issuedCapital: 1100,
      },
    ];
  }
}
</script>

<style scoped>
.table {
  display: flex;
  align-content: center;
  justify-content: center;
}
</style>
