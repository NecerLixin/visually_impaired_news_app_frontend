import wordModel from '../model/HistoryModel'
import ArrayList from '@ohos.util.ArrayList';
import { HistoryViewModel,ContentItem } from '../view/historyModel'

export async function getItem(){
  let items: HistoryViewModel[] = await wordModel.getWord()
  //console.log('test',JSON.stringify(items[0].content))
  return items
}
