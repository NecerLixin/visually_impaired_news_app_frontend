export function skip(){
  router.pushUrl({url:'pages/LoginPage'}, router.RouterMode.Standard, (err) => {
    if (err) {
      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
      return;
    }
    console.info('Invoke pushUrl succeeded.');
  })
}
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { RegisterViewModel } from '../view/RegisterViewModel'
@Entry
@Component
struct login {
  @State account: string = ''
  @State password1: string = ''
  @State password2: string = ''
  @State IsRegister: boolean = false
  @State message:RegisterViewModel = new RegisterViewModel(this.account,this.password2)
  build() {
    Column(){
      Row(){
        Image($r('app.media.Register_back'))
          .backgroundColor(Color.White)
          .width(30)
          .onClick(()=>skip())
        Text("返回")
          .fontSize(25)
          .onClick(()=>skip())
      }

      .width('100%')
      .height(60)
      .padding({left:14, right:14})
      .justifyContent(FlexAlign.Start)
      Column() {
        Image($r('app.media.icon'))
          .width(100)
          .height(100)
          .margin({
            top:'105vp',
            bottom:'9vp'
          })
        Text('注册界面')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin(10)
        Text('注册账号可以享受服务')
          .fontSize(16)
          .fontColor(Color.Gray)
        TextInput({placeholder:'注册账号/邮箱'})
          .margin({
            top:'30vp'
          })
          .onChange(value=>{
            this.account = value
          })
          .width('95%')
          .type(InputType.Normal)
        TextInput({placeholder:'密码'})
          .margin({
            top:'10vp'
          })
          .onChange(value=>{
            this.password1 = value
          })
          .width('95%')
          .type(InputType.Password)
        TextInput({placeholder:'再次输入密码'})
          .margin({
            top:'10vp'
          })
          .onChange(value=>{
            this.password2 = value
          })
          .width('95%')
          .type(InputType.Password)

        Button("注册")
          .width("90%")
          .height(50)
          .margin({
            top:"50 vp"
          })
          .onClick(()=>{
            if(this.password1 == this.password2 && this.password1 != ''){
              this.message.Setaccount(this.account)
              this.message.Setpassword(this.password1)
              this.message.Connet().then((res)=>{
                this.IsRegister = res
                if(this.IsRegister == true){
                  promptAction.showDialog({
                    title: '注册成功',
                    message: '',
                    buttons: [
                      {
                        text: '返回登录界面',
                        color: '#000000',
                      }
                    ],
                  }).then(data=>{
                    skip()
                  })
                }
                else{
                  promptAction.showDialog({
                    title: '注册失败',
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
            }
            if(this.password1 != this.password2){
              promptAction.showDialog({
                title: '两次输入密码不一致',
                message: '',
                buttons: [
                  {
                    text: '返回',
                    color: '#000000',
                  }
                ],
              })
            }
            if(this.password1 == ''){
              promptAction.showDialog({
                title: '密码不能为空',
                message: '',
                buttons: [
                  {
                    text: '返回',
                    color: '#000000',
                  }
                ],
              })
            }
            //console.log(this.password1)
            //console.log(this.password2)
          }


          )

      }
      .width('100%')
      .height('100%')
    }
  }
}