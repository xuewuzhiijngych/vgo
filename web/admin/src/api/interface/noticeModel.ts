import { ReqPage } from "@/api/interface/index";
// 公告模型
export namespace Notice {
  export interface ReqParams extends ReqPage {
    title: string;
    createTime: string[];
    status: number;
  }
  export interface ResList {
    id: number;
    created_at: string;
    updated_at: string;
    gender: number;
    title: string;
    status: number;
    content: string;
    remark: string;
  }
}
