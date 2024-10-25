<template>
  <el-drawer v-model="drawerVisible" :destroy-on-close="true" size="550px" title="设置权限">
    <el-form ref="ruleFormRef" label-width="100px" label-suffix=" :" :rules="rules" :model="formData">
      <el-form-item label="选择菜单" prop="menus">
        <el-tree-select
          v-model="formData!.menus"
          :data="options"
          filterable
          multiple
          show-checkbox
          :render-after-expand="false"
          :default-expand-all="true"
          check-strictly
          style="width: 280px"
        />
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="drawerVisible = false">取消</el-button>
      <el-button type="primary" @click="handleSubmit">确定</el-button>
    </template>
  </el-drawer>
</template>

<script setup lang="ts" name="SetMenuDrawer">
import { ref, onMounted, reactive } from "vue";
import { ElMessage, FormInstance } from "element-plus";
import { getMenus } from "@/api/modules/role";
import { getSelectTreeList } from "@/api/modules/menu";

const rules = reactive({
  menus: [{ required: true, message: "请选择菜单" }]
});

interface DrawerProps {
  id?: number;
  api?: (params: any) => Promise<any>;
  getTableList?: () => void;
}

const drawerVisible = ref(false);
const drawerProps = ref<DrawerProps>({});

// 表单数据
const formData = reactive({
  id: 0,
  menus: [] as string[]
});

// 菜单
const getCurrentMenus = async () => {
  if (!formData.id) return;
  try {
    let { data } = await getMenus({ id: formData.id });
    data = data.map(item => item.menu_id);
    formData.menus = data;
  } catch (error) {
    console.error("获取当前菜单失败:", error);
  }
};

// 接收父组件传过来的参数
const acceptParams = (params: DrawerProps) => {
  formData.id = params.id || 0;
  drawerProps.value = params;
  drawerVisible.value = true;
  getCurrentMenus(); // 获取当前菜单
};

// 获取菜单树
let options = ref();
const getMenuTree = async () => {
  const { data } = await getSelectTreeList({});
  options.value = data;
};

onMounted(() => {
  getMenuTree();
});

// 设置菜单
const ruleFormRef = ref<FormInstance>();
const handleSubmit = () => {
  ruleFormRef.value!.validate(async valid => {
    if (!valid) return;
    try {
      await drawerProps.value.api?.(formData);
      ElMessage.success({ message: `设置菜单成功！` });
      drawerProps.value.getTableList?.();
      drawerVisible.value = false;
      await getCurrentMenus();
    } catch (error) {
      console.error("设置菜单失败:", error);
    }
  });
};

defineExpose({
  acceptParams
});
</script>
