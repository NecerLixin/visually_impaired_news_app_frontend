import media from '@ohos.multimedia.media';
import common from '@ohos.app.ability.common';

export class AudioPlayer {
  private avPlayer;
  private count: number = 0;
  quit(){
    this.avPlayer.stop()
  }
  release(){
    this.avPlayer.release()
  }
  // 注册avplayer回调函数
  setAVPlayerCallback() {
    // error回调监听函数,当avPlayer在操作过程中出现错误时调用reset接口触发重置流程
    this.avPlayer.on('error', (err) => {
      console.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`);
      this.avPlayer.reset(); // 调用reset重置资源，触发idle状态
    })
    // 状态机变化回调函数
    this.avPlayer.on('stateChange', async (state, reason) => {
      switch (state) {
        case 'idle': // 成功调用reset接口后触发该状态机上报
          console.info('AVPlayer state idle called.');
          this.avPlayer.release(); // 调用release接口销毁实例对象
          break;
        case 'initialized': // avplayer 设置播放源后触发该状态上报
          console.info('AVPlayerstate initialized called.');
          this.avPlayer.prepare().then(() => {
            console.info('AVPlayer prepare succeeded.');
          }, (err) => {
            console.error(`Invoke prepare failed, code is ${err.code}, message is ${err.message}`);
          });
          break;
        case 'prepared': // prepare调用成功后上报该状态机
          console.info('AVPlayer state prepared called.');
          this.avPlayer.play((err)=>{
            if (err==null){
              console.log('play success');
            }else {
              console.error('play failed,error message is :'+err.message)
            }
          }); // 调用播放接口开始播放
          break;
        case 'playing': // play成功调用后触发该状态机上报
          console.info('AVPlayer state playing called.');
          break;
        case 'paused': // pause成功调用后触发该状态机上报
          console.info('AVPlayer state paused called.');
          this.avPlayer.play(); // 再次播放接口开始播放
          break;
        case 'completed': // 播放结束后触发该状态机上报
          console.info('AVPlayer state completed called.');
          this.avPlayer.stop(); //调用播放结束接口
          break;
        case 'stopped': // stop接口成功调用后触发该状态机上报
          console.info('AVPlayer state stopped called.');
          this.avPlayer.reset(); // 调用reset接口初始化avplayer状态
          break;
        case 'released':
          console.info('AVPlayer state released called.');
          break;
        default:
          console.info('AVPlayer state unknown called.');
          break;
      }
    })
  }
  async avPlayerUrlDemo(url) {
    // 创建avPlayer实例对象
    this.avPlayer = await media.createAVPlayer();
    // 创建状态机变化回调函数
    this.setAVPlayerCallback();
    // let url = 'http://172.16.24.81:5001/audio/tts.mp3';
    // 通过UIAbilityContext获取沙箱地址filesDir，以下为Stage模型获方式，如需在FA模型上获取请参考《访问应用沙箱》获取地址
    let context = getContext(this) as common.UIAbilityContext;
    console.log("Start avPlayer",url)

    this.avPlayer.url = url;
  }
}
const audioPlayer=new AudioPlayer()
export default audioPlayer