export function skip(){
  router.pushUrl({url:'pages/HomePage'}, router.RouterMode.Standard, (err) => {
    if (err) {
      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
      return;
    }
    console.info('Invoke pushUrl succeeded.');
  })
}
import {LoginModel} from '../model/LoginModel'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import accessibility from '@ohos.accessibility';

@Entry
@Component
struct LoginPage {
  @State account:string = ''
  @State password:string =''
  @State Islogin:boolean = false
  @State message:LoginModel = new LoginModel(this.account,this.password)
  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(100)
        .height(100)
        .margin({
          top:'105vp',
          bottom:'9vp'
        })
      Text('登录界面')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin(10)
      Text('登陆账号可以使用更多服务')
        .fontSize(16)
        .fontColor(Color.Gray)
      TextInput({placeholder:'账号/邮箱'})
        .margin({
          top:'30vp'
        })
        .width('95%')
        .type(InputType.Normal)
        .onChange(value=>{
          this.account = value
          this.message.Setaccount(this.account)
        })
      TextInput({placeholder:'密码'})
        .margin({
          top:'10vp'
        })
        .width('95%')
        .type(InputType.Password)
        .onChange(value=>{
          this.password = value
          this.message.Setpassword(this.password)

        })
      // Row() {
      //   Blank()
      //   Text("忘记密码？")
      //     .fontSize(18)
      //     .fontWeight(FontWeight.Bold)
      //     .fontColor(Color.Blue)
      // }.width("100%")
      // .margin({
      //   top:"10vp"
      // })
      Button("登录")
        .width("90%")
        .height(50)
        .margin({
          top:"50 vp"
        })
        .onClick(()=>{
          this.message.Connet().then((res)=>{
            this.Islogin = res
            console.log('Islogin:',this.Islogin)
            if(this.Islogin == true){
              router.replaceUrl({
                url: 'pages/HomePage',
                params: {
                  data1: '首页登录成功',
                  account :this.account,
                  itemIndex:-1
                }
              })
            }
            else{
              promptAction.showDialog({
                title: '登录失败',
                message: '',
                buttons: [
                  {
                    text: '返回',
                    color: '#000000',
                  }
                ],
              })
            }
          })
        })
      Text("注册账号")
        .margin({
          top:"10vp"
        })
        .fontWeight(FontWeight.Bold)
        .fontSize(20)
        .fontColor(Color.Blue)
        .onClick(()=>router.pushUrl({url:'pages/RegisterPage'}, router.RouterMode.Standard, (err) => {
          if (err) {
            console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
            return;
          }
          console.info('Invoke pushUrl succeeded.');
        }))
    }
    .width('100%')
    .height('100%')
  }
}