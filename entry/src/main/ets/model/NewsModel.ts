import http from '@ohos.net.http';
import {NewsViewModel} from '../view/NewsViewModel'
class NewsModel{
  BaseNewsURL=''
  getNews(news_id:string):Promise<NewsViewModel>{
    let httpRequest =http.createHttp();
    return new Promise((resolve,reject)=>{
      httpRequest.request(
        'http://172.16.24.81:5001/news/getnewsone?id='+news_id,
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