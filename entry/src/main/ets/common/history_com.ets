import wordModel from '../view/HistoryViewModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryModel } from '../model/HistoryModel'

export async function getItem(account:string){
  let items: HistoryModel[] = await wordModel.getWord(account)
  //console.log('test',JSON.stringify(items[0].content))
  return items
}
