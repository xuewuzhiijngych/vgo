import { ResPage } from "@/api/interface/index";
import { AdminUser } from "@/api/interface/adminUserModel";
import { PORT1 } from "@/api/config/servicePort";
import http from "@/api";

/**
 * 管理员
 */
// 获取列表
export const getList = (params: AdminUser.ReqParams) => {
  return http.get<ResPage<AdminUser.ResList>>(PORT1 + `/admin_user`, params);
};

// 新增
export const addInfo = (params: { id: string }) => {
  return http.post(PORT1 + `/admin_user/create`, params);
};

// 编辑
export const editInfo = (params: { id: string }) => {
  return http.post(PORT1 + `/notice/update`, params);
};

// 设置角色
export const setRoles = params => {
  return http.post(PORT1 + `/admin_user/set/role`, params);
};

// 获取角色
export const getRoles = params => {
  return http.post<Array<any>>(PORT1 + `/admin_user/get/role`, params);
};

// 删除
export const deleteInfo = (params: { id: string[] }) => {
  return http.post(PORT1 + `/admin_user/delete`, params);
};

// 切换状态
export const changeInfoStatus = (params: { id: string; status: number }) => {
  return http.post(PORT1 + `/notice/change`, params);
};

// 导出数据
export const exportInfo = (params: AdminUser.ReqParams) => {
  return http.download(PORT1 + `/user/export`, params);
};
