import { ReqPage } from "@/api/interface/index";
// 公告模型
export namespace AdminUser {
  export interface ReqParams extends ReqPage {
    status: number;
  }
  export interface ResList {
    id: number;
    created_at: string;
    updated_at: string;
    username: number;
    password: string;
    status: number;
  }
}
