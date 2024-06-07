
import { HistoryModel } from '../model/HistoryModel';
import http from '@ohos.net.http'
import defaultAppManager from '@ohos.bundle.defaultAppManager';
import ArrayList from '@ohos.util.ArrayList';
class HistoryViewModel{//创建连接
  wordUrl:string = ''//后端传上来的网址
  getWord(account:string):Promise<HistoryModel[]>{
    //1. 创建http对象
    let  httpRequest = http.createHttp()
    this.wordUrl = 'http://192.168.1.2:5001/users/gethistory?account='+account
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
            console.log('请求失败', JSON.stringify(response.result))
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
const wordModel = new HistoryViewModel()
export default wordModel