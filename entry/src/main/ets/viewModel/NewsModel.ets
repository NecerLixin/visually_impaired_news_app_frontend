import { CommonConstant as Const, PageState } from '../common/constant/CommonConstant';
import { ResponseResult } from './NewsViewModel';

export default class NewsModel {
  newsData: Array<ResponseResult> = [];
  currentPage: number = 1;
  pageSize: number = Const.PAGE_SIZE;
  pullDownRefreshText: ResourceStr = '下拉刷新';
  pullDownRefreshImage: Resource = $r('app.media.ic_pull_down_refresh');
  pullDownRefreshHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  isVisiblePullDown: boolean = false;
  pullUpLoadText: ResourceStr = '加载中...';
  pullUpLoadImage: Resource = $r('app.media.ic_pull_up_load');
  pullUpLoadHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  isVisiblePullUpLoad: boolean = false;
  offsetY: number = 0;
  //pageState: number = PageState.Loading;
  pageState: number = PageState.Success;
  hasMore: boolean = true;
  startIndex = 0;
  endIndex = 0;
  downY = 0;
  lastMoveY = 0;
  isRefreshing: boolean = false;
  isCanRefresh = false;
  isPullRefreshOperation = false;
  isLoading: boolean = false;
  isCanLoadMore: boolean = false;
}