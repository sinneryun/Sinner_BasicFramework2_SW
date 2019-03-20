# title: iOS 开发规范

## 一. 代码命名规则
### 1> 统一要求
> 
 • 前缀使用（如：项目名字首字母缩写）；
>
 • 含义清楚，尽量做到不需要注释也能了解其作用，若做不到，就加注释；
> 
 • 使用全称，不适用缩写；
 

### 2> 类的命名
> 
 • 大驼峰式命名：每个单词的首字母都采用大写字母(如：MFHomePageViewController)
> 
 • 后缀要求
> 
    1）Model:使用Model／Info作后缀（如：MFMineModel）；
	2）View: 使用View做后缀(如: MFMineView);
	3）ViewController: 使用Controller做后缀 (如: MFHomeController);
	4）ViewModel: 使用ViewModel做后缀 (如: MFMineViewModel);
	5）UITableCell:使用Cell做后缀(如: MFNewsCell);
	6）Protocol: 使用Delegate或者DataSource作为后缀(如: UITableViewDelegate);
	7）涉及重写某个控件:使用控件做后缀(如: MFTabBar、MFNavigationController);
	8）UI控件依次类推;
    

### 3> 私有变量
 • 小驼峰式命名：第一个单词以小写字母开始，后面的单词的首字母全部大写(如：firstName、lastName);
 
　
### 4> 协议
 • 根据苹果接口设计指导准则，协议名称用来描述一些东西是什么的时候是名词
> 
 例如：Collection,WidgetFactory。若协议名称用来描述能力应该以-ing, -able 或 -ible结尾，例如：Equatable,Resizing.
 

### 5> Enum
```javascript
根据Swift 3苹果接口设计指导文档，枚举中的值使用“小骆驼拼写法”命名规则

enum Shape {
    case rectangle
    case square 
    case  triangle
    case  circle
}

```

### 6> Delegate命名
 在定义委托方法时，第一个未命名参数应是委托数据源。

```javascript
正例
func namePickerView(_ namePickerView: NamePickerView, didSelectName name: String)

func namePickerViewShouldReload(_ namePickerView: NamePickerView) -> Bool)

反例

func didSelectName(namePicker: NamePickerViewController, name: String)

func namePickerShouldReload() -> Bool

```

## 二、代码组织
### 1> 在函数分组和protocol/delegate实现中使用// MARK: -来分类方法；


### 2> 定义常量使用 let 关键字，定义变量使用 var 关键字， 如果变量的值未来不会发生变化要使用常量。

使用类型属性来定义类型常量而不是实例常量，使用static let 可以定义类型属性常量。

```javascript
正例
enum Math {
   static let e = 2.718281828459045235360287  
   static let pi = 3.141592653589793238462643
}
radius * Math.pi * 2// 周长
Note: 使用枚举的好处是变量不会被无意初始化，且全局有效。

反例

let e=2.718281828459045235360287// 污染全局命名空间
let pi=3.141592653589793238462643

radius * pi * 2// pi是实例数据还是全局常量

```

### 3> 三元操作符：

```javascript
class TestDatabase: Database {
   var data: [String: CGFloat] = ["A": 1.2,"B": 3.2]
}

```

### 4> 类前缀
Swift中类别(类，结构体)在编译时会把模块设置为默认的命名空间，所以不用为了区分类别而添加前缀，比如RW。如果担心来自不同模块的两个名称发生冲突，可以在使用时添加模块名称来区分，注意不要滥用模块名称，仅在有可能发生冲突或疑惑的场景下使用。

```javascript
import SomeModule
let myClass = MyModule.UsefulClass()

```

### 5> 类和结构体
类定义

```javascript
class Circle: Shape {
  var x: Int, y: Int
  var radius: Double
  var diameter: Double{
      get {
        returnradius * 2
     } 
     set {      
        radius=newValue/2
    }  
}
   init(x: Int, y: Int, radius: Double) {
      self.x = x
      self.y = y
      self.radius = radius  
  }

 convenience init(x: Int, y: Int, diameter: Double) {
     self.init(x: x, y: y, radius: diameter/2)  
}

func describe() -> String{
    return"I am a circle at\(centerString())with an area of\(computeArea())"
}
override func computeArea() -> Double{
   return M_PI * radius * radius  
}

private func centerString()->String{
    return "(\(x),\(y))"
  }
}

```
上面的例子展示了下面的设计准则：

属性，变量，常量和参数等在声明定义时，其中: 符号后有空格，而: 符号前没有空格，比如x: Int, 和Circle: Shape

如果定义多个变量/数据结构时出于相同的目的和上下文，可以定义在同一行。

缩进getter，setter的定义和属性观察器的定义。

不需要添加internal这样的默认的修饰符。也不需要在重写一个方法时添加访问修饰符。


### self的使用

为了保持简洁，可以避免使用 self 关键词，因为Swift 在访问对象属性和调用对象方法不需要使用 self。

不过当在构造器中需要区分属性名和参数名时需要使用 self，还有当在在闭包表达式中引用属性值。

```javascript
class BoardLocation  {
    let row: Int, column: Int
    init(row: Int, column: Int)  {
        self.row = row
        self.column = column
        let closure = {
            print(self.row)    
         }  
    }
}

```

### 6> 黄金路径：当编码遇到条件判断时，左边的距离是黄金路径或幸福路径，因为路径越短，速度越快。不要嵌套if循环，多个返回语句是可以的。guard 就为此而生的。

```javascript
正例
func computeFFT(context: Context?, inputData: InputData?)  throws -> Frequencies {
    guard let context = context else {throwFFTError.NoContext }

   guard let inputData = inputData else { throwFFTError.NoInputData }

  //计算frequencies
  return frequencies
}

反例
func computeFFT(context: Context?, inputData: InputData?) throws -> Frequencies {
if let context = context {
    if let inputData = inputData {
           // 计算frequencies
          return frequencies    
    } else {
         throwFFTError.NoInputData    
     }  
   } else {
      throwFFTError.NoContext  
   }
}

```
#### 当有多个条件需要用 guard 或 if let 解包，可用复合语句避免嵌套。

```javascript
正例
guard let number1=number1, number2=number2, number3=number3 else{
    fatalError("impossible") 
}
// 处理number

反例
if let number1=number1 {
     if let number2=number2 {
           if let number3=number3 {
               // 处理number 
             } else {      
              fatalError("impossible")    
             }  
         } else {    
            fatalError("impossible")  
          }
      } else {
   fatalError("impossible")
}

```

  ## 三. 关于注释
　最好的代码是不需要注释的，尽量通过合理的命名；
　良好的代码把含义表达清楚，在必要的地方添加注释；
　注释需要与代码同步更新；
　如果做不到命名尽量的见名知意的话，就可以适当的添加一些注释或者mark；
 
### 1> 属性注释
```javascript
　　  实例:
　　　　/// 学生
　　　　@property (nonatomic, strong) Student *student;
```
    
### 2> 方法声明注释：
```javascript
       实例:
       /// 登录验证
  　 ///
  　 /// @param personId 用户名
  　 /// @param password 密码
  　 /// @param complete 执行完毕的block
  　 ///
  　 /// @return
　　+ (void)loginWithPersonId:(NSString *)personId password:(NSString *)password complete:(void (^)(CheckLogon *result))complete;
  
 
 
```
## 四. 关于UI布局
　使用Interface Builder进行界面布局：Xib文件的命名与其对应的文件保持相同；
 
 
## 五. 格式化代码

### 1> 指针 "*" 位置：定义一个对象时，指针 "*" 靠近变量（如: NSString *userName;）

### 2> 方法的声明和定义
　　在 - 、+ 和 返回值 之间留一个空格，方法名和第一个参数之间不留空格；在方法各个段之间应该也有一个空格(符合Apple的风格)；在参数前应该包含一个具有描述性的关键字来描述参数；”and”这个词的用法应该保留,它不应该用于多个参数来说明；

```javascript
实例:
-  (id)viewWithTag:(NSInteger)tag {.. .}
 
-  (void)setExampleText:(NSString *)text image:(UIImage *)image {.. .}
 
-  (void)sendAction:(SEL)aSelector to:(id)anObject forAllCells:(BOOL)flag {.. .}

 -   (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height {.. .}
 
错误实例：
- (instancetype)initWithWidth:(CGFloat)width andHeight:(CGFloat)height｛.. .｝
 - (instancetype)initWith:(int)width and:(int)height｛.. .｝
 

```
### 3> 代码缩进
 • 使用 xcode 默认缩进，即 tab = 4空格
 • 使用 xcode 中 re-indent 功能定期对代码格式进行整理
 • 相同类型变量声明需要独行声明
```javascript
　　     实例:
             CGRect frame = self.view.frame;
             CGFloat oringX = frame.origin.x;
             CGFloat oringY = frame.origin.y;
             CGFloat lineWidth = frame.size.width;
• Method与Method之间空一行，且方法后的括号与方法应缩为一行，中间以一个空格间隙分隔（视觉上更清晰和更易于组织）:
                    #pragma mark - private methods
                    - (void)samplePrivateMethod  {...}
 
                    - (void)sampleForIf  {...}
                    - 
                    
```
### 4> 对method进行分组(考虑):使用 // mark: - 方式对类的方法进行分组


### 5> 大括号写法
 •（不强制要求） 对于类的method: 左括号另起一行写(遵循苹果官方文档)
```javascript
- (id)initWithNibName:(NSString *)nibNameOrNilbundle:(NSBundle *)nibBundleOrNil
 　 {
 　　 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
         if (self) {
                   // Custom initialization
           }
         return self;
                    }
                    
```
 • （强制要求）对于其他使用场景( if 判断等): 左括号跟在第一行后边，中间以一个空格分隔
 • （不强制要求）任何需要写大括号的部分，不得省略（关于 “{}” 中有多行时必须强制使用 “{}”）




## APP主体框架模式: MVVM
```markdown
Project
────Main
        ──Appdelegate
        ──Tabar
        ──Navigation
        ──Base
		
────Model
  ──Type
        ──model	
	
────View
  ──Type
        ──View
        ──ViewController

────ViewModel
  ──Type
        ──Network API
        ──ViewModel

────Library
        ──Tool Category
        ──Network Tool
        ──Framework
        ──Other Lib

```




## 第三方库的统一引用 (使用频率高的)

> 网络请求
 • Alamofire   --   二次封装(根据业务需求.进行扩展)

> 网络图片
 • KingFisher

> 轮播图
 • SDCycle

> 刷新控件
 • MJRefresh

> 自动布局
 • SnapKit

> 转模型
 • SwiftyJSON










## Git 环境下开发模式 
> 
|---|---|-----master 分支 (线上分支,正式环境   非上线成功不可merge,  各版本对应APP版本号标记Tag)
> 
   |---|-----   hotfix 分支 (特殊情况处理 / 线上bug紧急修复  单拉分支进行debug,修复完成,测试通过后回归master)
> 
   ---|---|----dev  分支 (开发环境,迭代开发分支,对接后台稳定测试环境)(从function dev 和developer dev 禁止直接push / merge到dev分支, 需提交PR,填写修改/新增内容,视开发情况进行审阅,确认无误后合并至dev)
>
   --------XXfunction dev  功能点开发分支 (剥离于主体业务 / 暂时不接触整体业务的功能点开发分支)
>
   --------------XXdeveloper dev  开发人员分支 (开发人员细节开发,自我测试环境 )



每修改一个小功能点/UI/文案  进行一次commit (不用提交,仅本地commit)  添加commit说明 



