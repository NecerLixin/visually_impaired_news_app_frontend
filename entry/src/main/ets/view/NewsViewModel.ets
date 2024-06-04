import http from '@ohos.net.http';
import {NewsModel} from '../model/NewsModel'

class NewsViewModel{
  getNews(api:string):Promise<NewsModel>{
    let httpRequest =http.createHttp();
    return new Promise((resolve,reject)=>{
      httpRequest.request(
        api,
        {
          method:http.RequestMethod.GET,
          header:{'Content-Type':'application/json'}
        }
      )
        .then((resp:http.HttpResponse)=>{
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
const newsModel=new NewsViewModel()
export default newsModel