// @Entry
@Component
export struct OCRPage{
  build() {
    Column(){
      //上方返回栏等
      Row(){
        Button(){
          Row(){
            Image($r("app.media.back_ocr"))
              .width(30)
            Text($r('app.string.return'))
              .fontColor(Color.White)
          }
        }
        .backgroundColor(Color.Black)
        .margin({left:10})
      }
      .height("10%")
      .width("100%")
      .backgroundColor(Color.Black)
      //显示区域
      Row(){
        //图像显示区域
      }
      .backgroundColor(Color.White)
      .width('100%')
      .height('75%')
      //按钮行
      Row(){
        //照片按钮
        Button(){
          Column(){
            Image($r("app.media.pictures_ocr"))
              .width(30)
              // .height(10)
            Text($r('app.string.pictures'))
              .fontColor(Color.White)
              .margin({top:5})
          }
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Black)
        .width("20%")
        .margin({left:"10%",right:"10%"})

        //拍摄按钮
        Button(){
          Column(){
            Image($r("app.media.shot_ocr"))
              .width(50)
            Text($r('app.string.shot'))
              .fontColor(Color.White)
              .margin({top:5})
          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(HorizontalAlign.Center)
          .width("20%")
        }
        // .height(50)
        .type(ButtonType.Normal)
        .backgroundColor(Color.Black)

        //文字识别按钮
        Button(){
          Column(){
            Image($r("app.media.text_ocr"))
              .width(30)
            Text($r('app.string.text_ocr'))
              .fontColor(Color.White)
              .margin({top:5})
          }
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Black)
        .width("20%")
        .margin({left:"10%",right:"10%"})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .backgroundColor(Color.Black)
      .height('15%')
    }

  }

}

