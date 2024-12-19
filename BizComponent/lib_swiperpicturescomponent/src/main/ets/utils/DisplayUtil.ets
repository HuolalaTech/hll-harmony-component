import { display } from '@kit.ArkUI';

/**
 * 屏幕显示工具类
 */
export class DisplayUtil {
  /**
   * 获取屏幕宽度，单位px
   */
  public static screenWidth(): number {
    try {
      let displayClass = display.getDefaultDisplaySync();
      return displayClass.width
    } catch (exception) {
      console.error('Failed to obtain the default display object. Code: ' + JSON.stringify(exception));
    }
    return 1080
  }

  /**
   * 获取屏幕宽度，单位vp
   */
  public static screenWidthVp(): number {
    let width = DisplayUtil.screenWidth()
    return px2vp(width)
  }

  /**
   *
   * @returns
   */
  public static screenHeight() {
    try {
      let displayClass = display.getDefaultDisplaySync();
      return displayClass.height
    } catch (exception) {
      console.error('Failed to obtain the default display object. Code: ' + JSON.stringify(exception));
    }
    return 1920
  }

  /**
   * 获取屏幕高度，单位vp
   */
  public static screenHeightVp() {
    let height = DisplayUtil.screenHeight()
    return px2vp(height)
  }
}