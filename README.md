# TFQEnlargeButton
扩大UIButton点击区域
UIStackView 添加 UIbutton 不生效，因为这样的 button 的 bounds 是 0 0 0 0，无法计算点击区域

[博客地址](https://lizhidada.github.io/2019/09/25/iOS-%E6%89%A9%E5%A4%A7UIbutton%E7%82%B9%E5%87%BB%E5%8C%BA%E5%9F%9F/)

入口为`ViewController`，里边介绍了两种扩大`UIButton`点击区域的方法，其中需要说明的是，`showClickArea`属性的默认值为`NO`，设置`YES`的话就会显示当前`button`的可响应点击区域

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
## 扩大点击区域的两种方式

> 实现原理：重写系统```- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event```方法，实现对可响应区域的改变

### 1、添加`UIButton`分类

导入头文件`#import "TFQEnlargeButton.h"`，然后用`TFQEnlargeButton`创建`button`

- 优点
	- 使用方便，导入头文件，设置点击区域即可
- 缺点
	- 如果多个分类重写了`UIButton`的系统方法，那么最终只会执行某一个分类的系统方法，导致其它分类功能出问题
	- 分类重写父类方法之后，每个`UIButton`对象都会调用分类的方法，修改容易出问题
	
### 2、子类继承`UIButton`父类
导入头文件`#import "UIButton+TFQClickArea.h"`然后直接使用属性

- 优点
	- 不侵入系统的`UIButton`类，功能清晰
- 缺点
	- 使用的时候需要修改`UIButton`为子类`TFQEnlargeButton`，比分类多了一步操作
	
### 3、选择
首先分类是用来给原来的类增加方法的，并不是让大家用来重写父类方法的，且添加分类的方式有致命的缺点，所以这里强烈推荐继承的方式来实现扩大点击区域的功能
