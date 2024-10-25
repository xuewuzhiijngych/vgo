import { ResPage } from "@/api/interface/index";
import { Role } from "@/api/interface/roleModel";
import { PORT1 } from "@/api/config/servicePort";
import http from "@/api";

/**
 * 角色
 */
// 获取列表
export const getList = (params: Role.ReqParams) => {
  return http.get<ResPage<Role.ResList>>(PORT1 + `/role`, params);
};

// 获取全部
export const getAllRole = () => {
  return http.get<Array<any>>(PORT1 + `/role/allDataSource`, {});
};

// 新增
export const addInfo = (params: { id: string }) => {
  return http.post(PORT1 + `/role/create`, params);
};

// 设置菜单
export const setMenus = params => {
  return http.post(PORT1 + `/role/set/menu`, params);
};

// 获取菜单
export const getMenus = params => {
  return http.post<Array<any>>(PORT1 + `/role/get/menu`, params);
};

// 编辑
export const editInfo = (params: { id: string }) => {
  return http.post(PORT1 + `/role/update`, params);
};

// 删除
export const deleteInfo = (params: { id: string[] }) => {
  return http.post(PORT1 + `/role/delete`, params);
};
