<template>
  <div class="table-box">
    <ProTable ref="proTable" :columns="columns" :request-api="getTableList" :init-param="initParam" :data-callback="dataCallback">
      <!-- 表格 header 按钮 -->
      <template #tableHeader>
        <el-button v-auth="'create'" type="primary" :icon="CirclePlus" @click="openDrawer('新增')">新增</el-button>
      </template>
      <!-- 表格操作 -->
      <template #operation="scope">
        <el-button type="primary" v-auth="'update'" link :icon="EditPen" @click="openDrawer('编辑', scope.row)">编辑</el-button>
        <el-button type="primary" v-auth="'role'" link :icon="Tools" @click="openSetRoleDrawer(scope.row)">设置角色</el-button>
        <el-button type="danger" v-auth="'delete'" link :icon="Delete" @click="deleteAccount(scope.row)">删除</el-button>
      </template>
    </ProTable>
    <AdminUserFormDrawer ref="drawerRef" />
    <SetRoleDrawer ref="roleDrawerRef" />
  </div>
</template>

<script setup lang="tsx" name="adminUser">
import { ref, reactive } from "vue";
import { AdminUser } from "@/api/interface/adminUserModel";
import { useHandleData } from "@/hooks/useHandleData";
import { ElMessage } from "element-plus";
import ProTable from "@/components/ProTable/index.vue";
import { ProTableInstance, ColumnProps } from "@/components/ProTable/interface";
import { CirclePlus, Delete, Tools, EditPen } from "@element-plus/icons-vue";
import { getList, deleteInfo, addInfo, editInfo, setRoles, changeInfoStatus } from "@/api/modules/adminUser";
import AdminUserFormDrawer from "@/views/authority/admin_user/FormDrawer.vue";
import SetRoleDrawer from "@/views/authority/admin_user/SetRoleDrawer.vue";
import { useAuthButtons } from "@/hooks/useAuthButtons";
import { userStatus } from "@/utils/dict";

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
  // let newParams = JSON.parse(JSON.stringify(params));
  // newParams.createTime && (newParams.startTime = newParams.createTime[0]);
  // newParams.createTime && (newParams.endTime = newParams.createTime[1]);
  // delete newParams.createTime;
  return getList(params);
};

// 页面按钮权限（按钮权限既可以使用 hooks，也可以直接使用 v-auth 指令，指令适合直接绑定在按钮上，hooks 适合根据按钮权限显示不同的内容）
const { BUTTONS } = useAuthButtons();

// 切换用户状态
const changeStatus = async (row: AdminUser.ResList) => {
  await useHandleData(changeInfoStatus, { id: row.id, status: row.status == 1 ? 2 : 1 }, `切换【${row.username}】状态`);
  proTable.value?.getTableList();
};

// 表格配置项
const columns = reactive<ColumnProps<AdminUser.ResList>[]>([
  {
    prop: "id",
    label: "ID"
  },
  {
    prop: "username",
    label: "用户名"
  },
  {
    prop: "status",
    label: "状态",
    enum: userStatus,
    search: { el: "tree-select", props: { filterable: true } },
    render: scope => {
      return (
        <>
          {BUTTONS.value.status ? (
            <el-switch
              model-value={scope.row.status}
              active-text={scope.row.status == 1 ? "启用" : "禁用"}
              active-value={1}
              inactive-value={2}
              onClick={() => changeStatus(scope.row)}
            />
          ) : (
            <el-tag type={scope.row.status ? "success" : "danger"}>{scope.row.status ? "启用" : "禁用"}</el-tag>
          )}
        </>
      );
    }
  },
  {
    prop: "created_at",
    label: "创建时间",
    width: 200,
    render: scope => {
      return <>{new Date(scope.row.created_at).toLocaleString()}</>;
    },
    search: {
      el: "date-picker",
      span: 2,
      props: { type: "datetimerange", valueFormat: "YYYY-MM-DD HH:mm:ss" }
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
const drawerRef = ref<InstanceType<typeof AdminUserFormDrawer> | null>(null);
const openDrawer = (title: string, row: Partial<AdminUser.ResList> = {}) => {
  const params = {
    title,
    isView: title === "查看",
    row: { ...row },
    api: title === "新增" ? addInfo : title === "编辑" ? editInfo : undefined,
    getTableList: proTable.value?.getTableList
  };
  drawerRef.value?.acceptParams(params);
};

// 设置角色
const roleDrawerRef = ref<InstanceType<typeof SetRoleDrawer> | null>(null);
const openSetRoleDrawer = (row: Partial<AdminUser.ResList> = {}) => {
  const params = {
    id: row.id,
    api: setRoles,
    getTableList: proTable.value?.getTableList
  };
  roleDrawerRef.value?.acceptParams(params);
};

// 删除信息
const deleteAccount = async (params: AdminUser.ResList) => {
  await useHandleData(deleteInfo, { id: [params.id] }, `删除【${params.username}】`);
  proTable.value?.getTableList();
};
</script>
