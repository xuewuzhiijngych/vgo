import { ResPage } from "@/api/interface/index";
import { MenuModel } from "@/api/interface/menuModel";
import { PORT1 } from "@/api/config/servicePort";
import http from "@/api";

/**
 * 菜单权限
 */
// 获取列表
export const getTreeList = (params: MenuModel.ReqParams) => {
  return http.get<ResPage<MenuModel.ResList>>(PORT1 + `/menu/list`, params);
};

// 获取树形选择
export const getSelectTreeList = params => {
  return http.get<Array<any>>(PORT1 + `/menu/selectTreeDataSource`, params);
};

// 新增
export const addInfo = (params: { id: string }) => {
  return http.post(PORT1 + `/menu/create`, params);
};

// 编辑
export const editInfo = (params: { id: string }) => {
  return http.post(PORT1 + `/menu/update`, params);
};

// 删除
export const deleteInfo = (params: { id: string[] }) => {
  return http.post(PORT1 + `/menu/delete`, params);
};
