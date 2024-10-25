<template>
  <el-drawer v-model="drawerVisible" :destroy-on-close="true" size="750px" :title="`${drawerProps.title}`">
    <el-form
      ref="ruleFormRef"
      label-width="100px"
      label-suffix=" :"
      :rules="rules"
      :disabled="drawerProps.isView"
      :model="drawerProps.row"
      :hide-required-asterisk="drawerProps.isView"
    >
      <el-form-item label="菜单类型" prop="type">
        <el-radio-group v-model="drawerProps.row!.type">
          <el-radio v-for="item in menuTypes" :key="item.value" :value="item.value">{{ item.label }}</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="父级" prop="parent_id">
        <el-tree-select
          v-model="drawerProps.row!.parent_id"
          :data="options"
          filterable
          :render-after-expand="false"
          check-strictly
          style="width: 280px"
        />
      </el-form-item>
      <el-form-item label="路由标题" prop="title">
        <el-input v-model="drawerProps.row!.title" placeholder="请填写路由标题" clearable></el-input>
      </el-form-item>
      <el-form-item label="路由Name" prop="name">
        <el-input v-model="drawerProps.row!.name" placeholder="请填写路由Name" clearable></el-input>
      </el-form-item>
      <el-form-item label="Component" prop="component">
        <el-input v-model="drawerProps.row!.component" placeholder="请填写路由Name" clearable></el-input>
      </el-form-item>
      <el-form-item label="请求接口" prop="api">
        <el-input v-model="drawerProps.row!.api" placeholder="请填请求接口地址" clearable></el-input>
      </el-form-item>
      <el-form-item label="Icon" prop="icon">
        <SelectIcon v-model:icon-value="drawerProps.row!.icon" />
      </el-form-item>
      <el-form-item label="Path" prop="path">
        <el-input v-model="drawerProps.row!.path" placeholder="请填写路由Path" clearable></el-input>
      </el-form-item>
      <el-form-item label="高亮Path" prop="activeMenu">
        <el-input v-model="drawerProps.row!.activeMenu" placeholder="请填写高亮Path" clearable></el-input>
      </el-form-item>
      <el-form-item label="隐藏" prop="isHide">
        <el-switch v-model="drawerProps.row!.isHide" :active-value="1" :inactive-value="2" />
      </el-form-item>
      <el-form-item label="固定标签" prop="isAffix">
        <el-switch v-model="drawerProps.row!.isAffix" :active-value="1" :inactive-value="2" />
      </el-form-item>
      <el-form-item label="路由缓存" prop="isKeepAlive">
        <el-switch v-model="drawerProps.row!.isKeepAlive" :active-value="1" :inactive-value="2" />
      </el-form-item>
      <el-form-item label="全屏" prop="isFull">
        <el-switch v-model="drawerProps.row!.isFull" :active-value="1" :inactive-value="2" />
      </el-form-item>
      <el-form-item label="外链地址" prop="isLink">
        <el-input v-model="drawerProps.row!.isLink" placeholder="请填写外链地址" clearable></el-input>
      </el-form-item>
      <el-form-item label="排序" prop="sort">
        <el-input-number :min="0" v-model="drawerProps.row!.sort" placeholder="请填写排序"></el-input-number>
      </el-form-item>
    </el-form>
    <template #footer>
      <el-button @click="drawerVisible = false">取消</el-button>
      <el-button v-show="!drawerProps.isView" type="primary" @click="handleSubmit">确定</el-button>
    </template>
  </el-drawer>
</template>

<script setup lang="ts" name="MenuFormDrawer">
import { ref, onMounted, reactive } from "vue";
import { ElMessage, FormInstance } from "element-plus";
import { MenuModel } from "@/api/interface/menuModel";
import { menuTypes } from "@/utils/dict";
import { getSelectTreeList } from "@/api/modules/menu";
import SelectIcon from "@/components/SelectIcon/index.vue";

const rules = reactive({
  type: [{ required: true, message: "请选择菜单类型" }],
  title: [{ required: true, message: "请填写路由标题" }],
  name: [{ required: true, message: "请填写路由Name" }],
  sort: [{ required: true, message: "请填写排序" }]
});

// 获取菜单树
let options = ref();
const getMenuTree = async () => {
  const { data } = await getSelectTreeList({});
  const noOne = {
    label: "无父级-顶级菜单",
    value: 0,
    children: []
  };
  if (data.length > 0) {
    data.unshift(noOne);
  }
  options.value = data;
};

onMounted(() => {
  getMenuTree();
});

interface DrawerProps {
  title: string;
  isView: boolean;
  row: Partial<MenuModel.ResList>;
  api?: (params: any) => Promise<any>;
  getTableList?: () => void;
}

const drawerVisible = ref(false);
const drawerProps = ref<DrawerProps>({
  isView: false,
  title: "",
  row: {}
});

// 接收父组件传过来的参数
const acceptParams = (params: DrawerProps) => {
  drawerProps.value = { ...params, row: { ...params.row, sort: params.row.sort ?? 0 } };
  drawerVisible.value = true;
};

// 提交数据（新增/编辑）
const ruleFormRef = ref<FormInstance>();
const handleSubmit = () => {
  ruleFormRef.value!.validate(async valid => {
    if (!valid) return;
    try {
      await drawerProps.value.api!(drawerProps.value.row);
      ElMessage.success({ message: `${drawerProps.value.title}成功！` });
      drawerProps.value.getTableList!();
      drawerVisible.value = false;
      await getMenuTree();
    } catch (error) {
      console.log(error);
    }
  });
};

defineExpose({
  acceptParams
});
</script>
