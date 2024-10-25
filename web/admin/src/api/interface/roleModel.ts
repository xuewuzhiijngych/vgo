import { ReqPage } from "@/api/interface/index";
// 公告模型
export namespace Role {
  export interface ReqParams extends ReqPage {
    name: string;
    createTime: string[];
    status: number;
  }
  export interface ResList {
    id: number;
    created_at: string;
    updated_at: string;
    name: string;
    code: string;
  }
}
