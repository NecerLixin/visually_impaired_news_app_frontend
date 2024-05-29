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
@Entry
@Component
struct login {
  @State message: string = 'Hello World'
  @State password1: string = ''
  @State password2: string = ''
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
        TextInput({placeholder:'注册邮箱'})
          .margin({
            top:'30vp'
          })
          .width('95%')
          .type(InputType.Number)
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
              promptAction.showDialog({
                title: '注册成功',
                message: '',
                buttons: [
                  {
                    text: '返回首页',
                    color: '#000000',
                  }
                ],
              }).then(data=>{
                skip()
              })
            }
            if(this.password1 != this.password2){
              promptAction.showToast({
                message: '两次输入的密码不一致',
                duration: 2000,
              });
            }
            if(this.password1 == ''){
              promptAction.showToast({
                message: '请输入密码',
                duration: 2000,
              });
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