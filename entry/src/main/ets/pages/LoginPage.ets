
import router from '@ohos.router'
@Entry
@Component
struct LoginPage {
  @State message: string = 'Hello World'

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
        .type(InputType.Number)
      TextInput({placeholder:'密码'})
        .margin({
          top:'10vp'
        })
        .width('95%')
        .type(InputType.Password)
      Row() {
        Blank()
        Text("忘记密码？")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Blue)

      }.width("100%")
      .margin({
        top:"10vp"
      })
      Button("登录")
        .width("90%")
        .height(50)
        .margin({
          top:"50 vp"
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