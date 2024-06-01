import http from '@ohos.net.http';
export function Connect(account:string,news_id:string):Promise<boolean>{
  let httpRequest = http.createHttp();
  return new Promise((resolve,reject)=>{
    httpRequest.request(
      'http://172.16.24.81:5001/users/addhistory',
      {
        method: http.RequestMethod.POST,
        extraData:{
          "account":account,
          "news_id":news_id
        },
        expectDataType: http.HttpDataType.STRING
      }, (err, data) => {
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.info('Result:' + data.result);
        console.info('code:' + JSON.stringify(data.responseCode));
        if(JSON.stringify(data.responseCode) == '200')
        {
          console.log('登录成功')
          resolve(true)
        }
        else
        {
          console.log('登录失败');
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