/**
 * 数字工具类
 */
export class NumberUtil {
  /**
   * string转number
   *
   * @param value
   * @param radix
   * @returns
   */
  public static parseInt(value: string, radix?: number): number {
    return Number.parseInt(value, radix)
  }

  /**
   * string转number
   *
   * @param value
   * @returns
   */
  public static parseFloat(value: string): number {
    return Number.parseFloat(value)
  }

  /**
   * Replace count with text when the count number exceeds the maximum value.
   * @param count
   * @param max
   * @param replaceText
   */
  public static formatNumToMaxText(count: number, max: number, replaceText: string): string {
    return count > max ? max + replaceText : (count ?? 0).toString();
  }

  /**
   * Replace count with plus sign when the count number over one thousand
   * @param count
   */
  public static transNumberOverOneThousand(count: number): string {
    return NumberUtil.formatNumToMaxText(count, 999, '+');
  }

  public static timeStamp2MMss(timeStamp: number): string {
    let minute = Math.floor(timeStamp / 60)
    let second = Math.floor(timeStamp % 60)
    return minute + "分" + second + "秒";
  }

  /**
   * 秒转分向下取整
   *
   * @param origin
   * @returns
   */
  public static secondToMinuteFloor(origin: number): number {
    let minute = origin / 60
    return Math.floor(minute)
  }

  /**
   * 秒转分向上取整
   *
   * @param origin
   * @returns
   */
  public static secondToMinuteCeil(origin: number): number {
    let minute = origin / 60
    return Math.ceil(minute)
  }

  /**
   * 向下取整
   *
   * @param origin
   * @returns
   */
  public static floor(origin: number): number {
    return Math.floor(origin)
  }

  /**
   * 分转元
   *
   * @param cent
   * @returns
   */
  public static centToYuan(cent: number): string {
    let dollars = (cent / 100).toFixed(2);
    if (dollars.endsWith(".00")) {
      dollars = dollars.replace(".00", "")
    } else if (dollars.includes(".") && dollars.endsWith("0")) {
      dollars = dollars.substring(0, dollars.length - 1)
    }
    return dollars;
  }

  /**
   * java 代码为 (guide_price.toFloat() / 100).roundToInt()
   * @param cent
   * @returns
   */
  public static centToYuanNumber(cent: number): number {
    let dollars = (cent / 100)
    return dollars;
  }
}