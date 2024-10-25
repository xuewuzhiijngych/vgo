<template>
  <div class="table-box">
    <div class="upload content-box">
      <div class="card img-box">
        <el-form label-width="100px" label-suffix=" :" :rules="rules" :model="fromModel">
          <el-form ref="ruleFormRef" label-width="100px" label-suffix=" :" :rules="rules" :model="fromModel">
            <el-form-item label="用户头像" prop="avatar">
              <UploadImg v-model:image-url="fromModel.avatar" width="135px" height="135px" :file-size="3">
                <template #empty>
                  <el-icon><Avatar /></el-icon>
                  <span>请上传头像</span>
                </template>
                <template #tip> 头像大小不能超过 3M </template>
              </UploadImg>
            </el-form-item>
            <el-form-item label="用户照片" prop="photo">
              <UploadImgs v-model:file-list="fromModel.photo" :limit="3" height="140px" width="140px">
                <template #empty>
                  <el-icon><Picture /></el-icon>
                  <span>请上传照片</span>
                </template>
                <template #tip> 最多上传 3 张照片 </template>
              </UploadImgs>
            </el-form-item>
            <el-form-item label="用户姓名" prop="username">
              <el-input v-model="fromModel.username" placeholder="请填写用户姓名" clearable></el-input>
            </el-form-item>
            <el-form-item>
              <el-button> 取消 </el-button>
              <el-button type="primary" @click="submit"> 确定 </el-button>
            </el-form-item>
          </el-form>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts" name="upload">
import { ref, reactive } from "vue";
import { FormInstance } from "element-plus";
import UploadImg from "@/components/Upload/Img.vue";
import UploadImgs from "@/components/Upload/Imgs.vue";

const rules = reactive({
  avatar: [{ required: true, message: "请上传用户头像" }],
  photo: [{ required: true, message: "请上传用户照片" }],
  username: [{ required: true, message: "请填写用户姓名" }]
});

const fromModel = ref({
  avatar: "",
  photo: [{ name: "img", url: "https://i.imgtg.com/2023/01/16/QR57a.jpg" }],
  username: ""
});

const ruleFormRef = ref<FormInstance>();
const submit = () => {
  ruleFormRef.value!.validate(valid => {
    console.log(valid);
  });
};
</script>

<style scoped lang="scss">
@import "./index.scss";
</style>
