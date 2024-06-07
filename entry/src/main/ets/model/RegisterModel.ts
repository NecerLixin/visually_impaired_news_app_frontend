import http from '@ohos.net.http';
export class RegisterModel{
  account:string
  password:string
  msg:string
  constructor(account:string,password:string) {
    this.account = account
    this.password = password
  }

  Setaccount(account:string){
    this.account = account
  }

  Setpassword(password:string){
    this.password = password
  }

  Connet():Promise<boolean>{
    let httpRequest = http.createHttp();
    return new Promise((resolve,reject)=>{
      httpRequest.request(
        'http://192.168.1.2:5001/users/register',
        {
          method: http.RequestMethod.POST,
          extraData:{
            "account":this.account,
            "password":this.password
          },
          expectDataType: http.HttpDataType.STRING
        }, (err, data) => {
        if (!err) {
          // data.result为HTTP响应内容，可根据业务需要进行解析
          console.log('account:',this.account)
          console.log('password:',this.password)
          console.info('Result:' + data.result);
          this.msg = data.result["msg"]
          console.info('code:' + JSON.stringify(data.responseCode));
          if(JSON.stringify(data.responseCode) == '200')
          {
            console.log('注册成功')
            resolve(true)
          }
          else
          {
            console.log('注册失败');
            resolve(false)
          }
          // data.header为HTTP响应头，可根据业务需要进行解析
          console.info('header:' + JSON.stringify(data.header));
          console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
        } else {
          console.info('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
          // 当该请求使用完毕时，调用destroy方法主动销毁
          httpRequest.destroy();
        }
      })
    })
  }
}