import { ReqPage } from "@/api/interface/index";
// 菜单权限模型
export namespace MenuModel {
  export interface ReqParams extends ReqPage {
    title: string;
    createTime: string[];
    status: number;
  }
  export interface ResList {
    id: number;
    created_at: string;
    updated_at: string;
    parent_id: number;
    path: string;
    name: string;
    redirect: string;
    api: string;
    component: string;
    icon: string;
    title: string;
    activeMenu: string;
    isLink: string;
    isHide: number;
    isFull: number;
    isAffix: number;
    isKeepAlive: number;
    status: number;
    type: number;
    sort: number;
    meta: object;
    children: ResList[];
  }
  export interface ResTreeList {
    value: string;
    label: string;
    children: ResTreeList[];
  }
}
