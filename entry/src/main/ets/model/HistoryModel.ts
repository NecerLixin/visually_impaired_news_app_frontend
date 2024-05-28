
import { HistoryViewModel } from '../view/historyModel';
import { ContentItem } from '../view/historyModel'
import http from '@ohos.net.http'
import defaultAppManager from '@ohos.bundle.defaultAppManager';
import ArrayList from '@ohos.util.ArrayList';
class HistoryModel{
  wordUrl:string = 'http://127.0.0.1:5000/index'
  getWord():Promise<HistoryViewModel[]>{
    //1. 创建http对象
    let  httpRequest = http.createHttp()

    return new Promise((resolve,reject)=>{
      httpRequest.request(this.wordUrl,{
        method:http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        },
        // extraData:"username=123&age=21"
        //extraData:{'param1':'value1','param2':'value2','param3':'value3'}
      })
        .then((response:http.HttpResponse) => {
          console.log("返回代码：",response.responseCode.toString())
          // console.log(response.result.toString())
          if(response.responseCode == 200){
            //console.log('请求成功',response.result)
            //resolve(JSON.parse(response.result.toString()))
            resolve(JSON.parse(response.result.toString()))
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
const wordModel = new HistoryModel()
export default wordModel