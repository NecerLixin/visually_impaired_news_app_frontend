// import cameraDemo from 'libentry.so';
import * as Common from '../common/Constants'
import { SettingDataObj } from '../common/Constants'
import { focusPage } from '../views/FocusPage';
import { FocusAreaPage } from '../views/FocusAreaPage';
@Entry
@Component
struct OCRPage{
  private mXComponentController: XComponentController = new XComponentController();
  @State onShow: boolean = false
  @State surfaceId: string = ''
  @State cameraDeviceIndex: number = 0;
  // @State focusPointBol: boolean = false;
  @State focusPointBol: boolean = false
  @State exposureBol: boolean = true;
  @State focusPointVal: Array<number> = [0, 0];
  @State xComponentWidth: number = 384;
  @State xComponentHeight: number = 450;
  @State exposureNum: number = 0;
  private settingDataObj: SettingDataObj = {
    mirrorBol: false,
    videoStabilizationMode: 0,
    exposureMode: 1,
    focusMode: 2,
    photoQuality: 1,
    locationBol: false,
    photoFormat: 1,
    photoOrientation: 0,
    photoResolution: 0,
    videoResolution: 0,
    videoFrame: 0,
    referenceLineBol: false
  };
  build() {
    Stack() {
      if (this.onShow) {
        // general appearance of a picture
        XComponent({
          id: 'componentId',
          type: 'surface',
          controller: this.mXComponentController
        })
          .onLoad(async () => {
            // Logger.info(TAG, 'onLoad is called');
            this.surfaceId = this.mXComponentController.getXComponentSurfaceId();
            // Logger.info(TAG, `onLoad surfaceId: ${this.surfaceId}`);
            // Logger.error(TAG, `initCamera start`);
            // cameraDemo.initCamera(this.surfaceId, this.settingDataObj.focusMode, this.cameraDeviceIndex);
            let device = Common.cameraDeviceIndex;
            device = this.cameraDeviceIndex;
            // Logger.error(TAG, `initCamera end`);
          })
          .backgroundColor(Color.Blue)
          .width('100%')
          .height('70%')

        // REFERENCE LINE
        // dividerPage({ referenceLineBol: this.referenceLineBol });
        // Set icon
        // Button() {
        //   Image($r('app.media.icon_camera_setting'))
        //     .width('120px').height('120px')
        // }
        // .width('120px')
        // .height('120px')
        // .backgroundColor('rgba(255,255,255,0.20)')
        // .borderRadius('40px')
        // .position({ x: '80%', y: '3%' })
        // .id('CameraSettings')
        // .onClick(() => {
        //   // Open the settings pop-up box
        //   this.settingDialogController.open()
        // });
        // Exposure frame and focus frame
        focusPage({
          focusPointBol: $focusPointBol,
          focusPointVal: $focusPointVal,
          exposureBol: $exposureBol,
          exposureNum: $exposureNum
        })
        // Exposure focusing finger click area
        FocusAreaPage({
          focusPointBol: $focusPointBol,
          focusPointVal: $focusPointVal,
          exposureBol: $exposureBol,
          exposureNum: $exposureNum,
          xComponentWidth: this.xComponentWidth,
          xComponentHeight: this.xComponentHeight
        });
        // CountDown
        // CountdownPage({ countdownNum: $countdownNum });
        // FlashLight
        // FlashingLightPage();
        // Slide
        // SlidePage();
        // Reverse camera_Multiple workstations_Take photos_Video
        // modeSwitchPage({
        //   surfaceId: this.surfaceId,
        //   cameraDeviceIndex: $cameraDeviceIndex,
        //   countdownNum: $countdownNum
        // });
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Black)
  }
}

