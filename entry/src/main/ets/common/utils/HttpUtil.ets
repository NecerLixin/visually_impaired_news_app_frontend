/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//import { HistoryViewModel } from '../view/historyModel';
//import { ContentItem } from '../view/historyModel'
//import http from '@ohos.net.http'
import defaultAppManager from '@ohos.bundle.defaultAppManager';
import ArrayList from '@ohos.util.ArrayList';
import http from '@ohos.net.http';
import { ResponseResult } from '../../viewModel/HomeViewModel';
import { CommonConstant as Const, ContentType } from '../../../../../../../visually_impaired_news_app_frontend/entry/src/main/ets/common/constant/CommonConstant';

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 */


class httpRequestGet{
  url:string = 'http://172.16.24.81:5001/news/getnews'
  getWord():Promise<ResponseResult[]>{
  //1. 创建http对象
    let  httpRequest = http.createHttp()

    return new Promise((resolve,reject)=>{
      httpRequest.request(this.url,{
        method:http.RequestMethod.GET,
        header: {
          'Content-Type': ContentType.JSON
        }
        // extraData:"username=123&age=21"
        //extraData:{'param1':'value1','param2':'value2','param3':'value3'}
      })
        .then((response:http.HttpResponse) => {
          // console.log(response.result.toString())
          if(response.responseCode == 200){
            //resolve(JSON.parse(response.result.toString()))
            resolve(JSON.parse(response.result.toString()))

            console.log('请求成功', JSON.stringify(response))
          }
          else{
            console.log('请求失败', JSON.stringify(response))
            reject(JSON.stringify(response))
          }
        })
        .catch(error => {
          console.log('请求失败', JSON.stringify(error))
          reject(JSON.stringify(error))
        })
    })
  }

}

const HttpRequestGet = new httpRequestGet()
export default HttpRequestGet