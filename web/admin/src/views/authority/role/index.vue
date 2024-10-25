<template>
  <div class="table-box">
    <ProTable ref="proTable" :columns="columns" :request-api="getTableList" :init-param="initParam" :data-callback="dataCallback">
      <!-- 表格 header 按钮 -->
      <template #tableHeader>
        <el-button v-auth="'create'" type="primary" :icon="CirclePlus" @click="openDrawer('新增')">新增</el-button>
      </template>
      <!-- 表格操作 -->
      <template #operation="scope">
        <el-button type="primary" v-auth="'authority'" link :icon="Tools" @click="openSetMenuDrawer(scope.row)">
          设置权限
        </el-button>
        <br />
        <el-button type="primary" v-auth="'update'" link :icon="EditPen" @click="openDrawer('编辑', scope.row)">编辑</el-button>
        <el-button type="danger" v-auth="'delete'" link :icon="Delete" @click="deleteAccount(scope.row)">删除</el-button>
      </template>
    </ProTable>
    <RoleFormDrawer ref="drawerRef" />
    <SetMenuDrawer ref="menuDrawerRef" />
  </div>
</template>

<script setup lang="tsx" name="role">
import { ref, reactive } from "vue";
import { Role } from "@/api/interface/roleModel";
import { useHandleData } from "@/hooks/useHandleData";
import ProTable from "@/components/ProTable/index.vue";
import { ProTableInstance, ColumnProps } from "@/components/ProTable/interface";
import { CirclePlus, Delete, Tools, EditPen } from "@element-plus/icons-vue";
import { getList, deleteInfo, addInfo, editInfo, setMenus } from "@/api/modules/role";
import RoleFormDrawer from "@/views/authority/role/FormDrawer.vue";
import SetMenuDrawer from "@/views/authority/role/SetMenuDrawer.vue";

// ProTable 实例
const proTable = ref<ProTableInstance>();

// 如果表格需要初始化请求参数，直接定义传给 ProTable (之后每次请求都会自动带上该参数，此参数更改之后也会一直带上，改变此参数会自动刷新表格数据)
const initParam = reactive({ example: 1 });

// dataCallback 是对于返回的表格数据做处理，如果你后台返回的数据不是 list && total 这些字段，可以在这里进行处理成这些字段
// 或者直接去 hooks/useTable.ts 文件中把字段改为你后端对应的就行
const dataCallback = (data: any) => {
  return {
    list: data.list,
    total: data.total
  };
};

// 如果你想在请求之前对当前请求参数做一些操作，可以自定义如下函数：params 为当前所有的请求参数（包括分页），最后返回请求列表接口
// 默认不做操作就直接在 ProTable 组件上绑定	:requestApi="getList"
const getTableList = (params: any) => {
  return getList(params);
};

// 表格配置项
const columns = reactive<ColumnProps<Role.ResList>[]>([
  {
    prop: "id",
    label: "ID"
  },
  {
    prop: "name",
    label: "名称"
  },
  {
    prop: "code",
    label: "标识"
  },
  {
    prop: "created_at",
    label: "创建时间",
    width: 200,
    render: scope => {
      return <>{new Date(scope.row.created_at).toLocaleString()}</>;
    }
  },
  {
    prop: "updated_at",
    label: "更新时间",
    width: 180,
    render: scope => {
      return <>{new Date(scope.row.updated_at).toLocaleString()}</>;
    }
  },
  { prop: "operation", label: "操作", fixed: "right", width: 330 }
]);

// 打开 drawer(新增、查看、编辑)
const drawerRef = ref<InstanceType<typeof RoleFormDrawer> | null>(null);
const openDrawer = (title: string, row: Partial<Role.ResList> = {}) => {
  const params = {
    title,
    isView: title === "查看",
    row: { ...row },
    api: title === "新增" ? addInfo : title === "编辑" ? editInfo : undefined,
    getTableList: proTable.value?.getTableList
  };
  drawerRef.value?.acceptParams(params);
};

// 设置菜单
const menuDrawerRef = ref<InstanceType<typeof SetMenuDrawer> | null>(null);
const openSetMenuDrawer = (row: Partial<Role.ResList> = {}) => {
  const params = {
    id: row.id,
    api: setMenus,
    getTableList: proTable.value?.getTableList
  };
  menuDrawerRef.value?.acceptParams(params);
};

// 删除信息
const deleteAccount = async (params: Role.ResList) => {
  await useHandleData(deleteInfo, { id: [params.id] }, `删除【${params.name}】`);
  proTable.value?.getTableList();
};
</script>
