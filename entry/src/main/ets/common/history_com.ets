import wordModel from '../model/HistoryModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryViewModel } from '../view/HistoryViewModel'

export async function getItem(account:string){
  let items: HistoryViewModel[] = await wordModel.getWord(account)
  //console.log('test',JSON.stringify(items[0].content))
  return items
}
