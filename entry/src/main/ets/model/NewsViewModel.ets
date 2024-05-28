import http from '@ohos.net.http';
import socket from '@ohos.net.socket';
export  class Item{
  name:string
  image:ResourceStr
  info:string
  constructor(name:string,image:ResourceStr,info:string) {
    this.name=name
    this.image=image
    this.info=info
  }
}
export class NewsPic{
  image:ResourceStr
  info:string
  constructor(image:ResourceStr,info:string) {
    this.image=image
    this.info=info
  }
}
export class NewsTittle{
  tittle:string
  author:string
  date:string

  constructor(tittle:string,author:string,date:string) {
    this.tittle=tittle
    this.author=author
    this.date=date
  }
}
class GetApi{
  BaseNewsURL='http://127.0.0.1:5000/index'
  getNews(){
    return new Promise((resolve,reject)=>{
      let httpRequest =http.createHttp();
      httpRequest.on('headersReceive',(header)=>{
        console.info('header'+JSON.stringify(header))
      })
      httpRequest.request(
        'http://127.0.0.1:5000/index',
        {
          method:http.RequestMethod.GET
        }
      )
        .then((resp:http.HttpResponse)=>{
          if(resp.responseCode === 200){
            console.log('请求成功',resp.result)
            resolve(JSON.parse(resp.result.toString()))
          }else {
            console.log('请求失败！',JSON.stringify(resp))
          }
        })
        .catch((err:Error)=>{console.log('请求失败',JSON.stringify(err))})
    })
  }
}
const getApi=new GetApi()
export default getApi