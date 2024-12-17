import util from '@ohos.util';
import buffer from '@ohos.buffer';

/**
 * 文本工具类
 */
export class StringUtil {
  public static isNullOrEmpty(value: string | undefined): boolean {
    if (value == undefined || value.length == 0) {
      return true
    }
    return false
  }

  /** 任何「空字符串」都视为null
   * @example elvis表达式: let nickName = StringUtil.getOrNull(name) ?? 'default name' */
  public static getOrNull(value: string | undefined | null): string | null {
    if (value == undefined || value == null || value.length == 0 || value.trim().length == 0) {
      return null
    }
    return value
  }

  /**
   * 字符串数组变成字符串，中间加tag符号
   *
   * @param stringList
   * @param tag
   * @return
   */
  public static join(stringList: string[], tag: string): string {
    let str = "";
    if (undefined != stringList && stringList.length > 0) {
      for (let i = 0; i < stringList.length; i++) {
        str = str + stringList[i] + tag;
      }
    }
    if (!StringUtil.isNullOrEmpty(str)) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }

  public static stringToArrayBuffer(str: string): ArrayBuffer {
    return buffer.from(str, 'utf-8').buffer
  }

  public static stringToUint8Array(str: string): Uint8Array {
    let arr = new Uint8Array(str.length);
    for (let i = 0, j = str.length; i < j; ++i) {
      arr[i] = str.charCodeAt(i);
    }
    return arr;
  }

  /**utf8转码
   * @param input
   * @returns
   */
  public static stringToUint8ArrayUTF8(str: string): Uint8Array {
    return new Uint8Array(buffer.from(str, 'utf-8').buffer);
  }

  /**utf8转码
   * @param input
   * @returns
   */
  public static uint8Array2String(input: Uint8Array): string {
    let textDecoder = util.TextDecoder.create("utf-8", { ignoreBOM: true })
    return textDecoder.decodeWithStream(input, { stream: false });
  }

  public static stringToUint8ArrayLen(str, len = undefined): Uint8Array {
    let arr = [];
    if (len == undefined) {
      len = str.length
    }
    for (let i = 0; i < len; i++) {
      if (str.length > i) {
        arr.push(str.charCodeAt(i))
      } else {
        arr.push(0)
      }
    }
    return new Uint8Array(arr);
  }

  // public static uint8ArrayToStringUTF8(array: Uint8Array): string {
  //   let textDecoder = new util.TextDecoder("utf-8", { ignoreBOM: true });
  //   let retStr = textDecoder.decode(array, { stream: false });
  //   return retStr
  // }

  public static uint8ArrayToString(array: Uint8Array): string {
    // 将UTF-8编码转换成Unicode编码
    let out: string = "";
    let index: number = 0;
    let len: number = array.length;
    while (index < len) {
      let character = array[index++];
      switch (character >> 4) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
          out += String.fromCharCode(character);
          break;
        case 12:
        case 13:
          out += String.fromCharCode(((character & 0x1F) << 6) | (array[index++] & 0x3F));
          break;
        case 14:
          out += String.fromCharCode(((character & 0x0F) << 12) | ((array[index++] & 0x3F) << 6) |
            ((array[index++] & 0x3F) << 0));
          break;
        default:
          break;
      }
    }
    return out;
  }

  /**
   * 身份证除第一位和最后一位全部替换为*
   * @param idCard
   * @returns
   */
  public static encryptionIdCard(idCard: string): string {
    if (StringUtil.isNullOrEmpty(idCard)) {
      return "";
    }
    if (idCard.length == 2) {
      return idCard;
    }
    let first = idCard.charAt(0).toString()
    let last = idCard.charAt(idCard.length - 1).toString()
    for (let i = 0; i < idCard.length - 2; i++) {
      first += "*";
    }
    return first + last;
  }

  public static getStandardIds(data: string): string[] {
    let result: string[] = []
    if (StringUtil.isNullOrEmpty(data)) {
      return result
    }
    if (!data.includes(",")) {
      result.push(data)
    } else {
      result = data?.split(",") ?? []
    }
    return result
  }
}