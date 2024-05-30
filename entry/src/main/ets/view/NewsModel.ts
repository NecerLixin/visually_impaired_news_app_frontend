import http from '@ohos.net.http';
import {NewsViewModel} from '../model/NewsViewModel'
class NewsModel{
  BaseNewsURL='http://127.0.0.1:5000/index'
  getNews():Promise<NewsViewModel>{
    let httpRequest =http.createHttp();
    return new Promise((resolve,reject)=>{
      httpRequest.request(
        'http://127.0.0.1:5000/index',
        {
          method:http.RequestMethod.GET,
          header:{'Content-Type':'application/json'}
        }
      )
        .then((resp:http.HttpResponse)=>{
          // console.log("返回代码：",resp.responseCode.toString())
          //console.log('222')
          if(resp.responseCode === 200){
            resolve(JSON.parse(resp.result.toString()))
          }else {
            console.log('请求失败！',JSON.stringify(resp))
            reject(JSON.stringify(resp))
          }
        })
        .catch((err:Error)=>{console.log('请求失败',JSON.stringify(err))
        reject(JSON.stringify(err))})
    })
  }
}
const newsModel=new NewsModel()
export default newsModel