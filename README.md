# ZY_ZoomHeader
**滚动视图添加下拉放大视图**
### 使用：
> - 将需要做缩放效果的头视图继承自`ZYZoomHeaderView`
> - 设置头视图的背景图片
> `self.image = [UIImage imageNamed:@"bg"]`;
> - 添加头视图到`UITableView`或`UICollectionView`上
> 
> ```
 CustomHeaderView * header = [[CustomHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
self.tableView.zy_zoomHeader = header;
```
