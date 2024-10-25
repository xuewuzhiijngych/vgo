<template>
  <el-drawer v-model="drawerVisible" :destroy-on-close="true" size="450px" title="设置角色">
    <el-form ref="ruleFormRef" label-width="100px" label-suffix=" :" :rules="rules" :model="formData">
      <el-form-item label="选择角色" prop="roles">
        <el-checkbox-group v-model="formData.roles">
          <el-checkbox
            style="margin-bottom: 5px; margin-top: 5px"
            v-for="role in allRoles"
            :value="role.code"
            :key="role.id"
            size="large"
            border
          >
            {{ role.name }}--{{ role.code }}
          </el-checkbox>
        </el-checkbox-group>
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="drawerVisible = false">取消</el-button>
      <el-button type="primary" @click="handleSubmit">确定</el-button>
    </template>
  </el-drawer>
</template>

<script setup lang="ts" name="SetRoleDrawer">
import { ref, onMounted, reactive } from "vue";
import { ElMessage, FormInstance } from "element-plus";
import { getAllRole } from "@/api/modules/role";
import { getRoles } from "@/api/modules/adminUser";

// 角色
let allRoles = ref<any[]>([]);
const getSysRole = async () => {
  try {
    const { data } = await getAllRole();
    allRoles.value = data;
  } catch (error) {
    console.error("获取角色列表失败:", error);
  }
};

const rules = reactive({
  roles: [{ required: true, message: "请选择角色" }]
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
  roles: [] as string[]
});

// 角色
const getCurrentRoles = async () => {
  if (!formData.id) return;
  try {
    const { data } = await getRoles({ id: formData.id });
    formData.roles = data;
  } catch (error) {
    console.error("获取当前角色失败:", error);
  }
};

// 接收父组件传过来的参数
const acceptParams = (params: DrawerProps) => {
  formData.id = params.id || 0;
  drawerProps.value = params;
  drawerVisible.value = true;
  getCurrentRoles(); // 获取当前角色
};

onMounted(() => {
  getSysRole();
});

// 设置角色
const ruleFormRef = ref<FormInstance>();
const handleSubmit = () => {
  ruleFormRef.value!.validate(async valid => {
    if (!valid) return;
    try {
      await drawerProps.value.api?.(formData);
      ElMessage.success({ message: `设置角色成功！` });
      drawerProps.value.getTableList?.();
      drawerVisible.value = false;
      await getCurrentRoles();
    } catch (error) {
      console.error("设置角色失败:", error);
    }
  });
};

defineExpose({
  acceptParams
});
</script>
