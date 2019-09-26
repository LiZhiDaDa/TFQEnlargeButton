# TFQEnlargeButton
扩大UIButton点击区域


入口为`ViewController`，里边介绍了两种扩大`UIButton`点击区域的方法，其中需要说明的是，`showClickArea`属性的默认值为`NO`，设置`YES`的话就会显示当前`button`的课响应点击区域

```
/**
 *  对button的上、左、下、右点击区域进行扩大，正数表示缩小点击区域
 *  button.clickEdgeInsets = UIEdgeInsetsMake(-1, -2, -3, -4);
 */
@property (nonatomic, assign) UIEdgeInsets clickEdgeInsets;

///成倍扩大点击区域，传值<=1点击区域不变
@property (nonatomic, assign) CGFloat clickScale;

///成倍扩大横向点击区域，传值<=1点击区域不变
@property (nonatomic, assign) CGFloat clickWidthScale;

///成倍扩大纵向点击区域，传值<=1点击区域不变
@property (nonatomic, assign) CGFloat clickHeightScale;

///是否显示点击区域，供调试使用，默认为NO，半透明的红色区域就是点击区域
@property (nonatomic, assign) BOOL showClickArea;
```
