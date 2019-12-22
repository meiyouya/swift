import UIKit


var str = "Hello, Playground"


var a: Int = 110

typealias MyInt = Int
var b: MyInt = 6

var c: Int?
//c!    值为nil的时候，使用感叹号获取会报错
c = 2
print(c)
print(c!)

var d: String!
d = "Hello,Swift"
print(d)
print(d!)

if let result = d {
    // d里面有值会走到这里
    print("d里有值")
} else {
    // d里没有值会走到这里
    print("d里没有值")
}

let constA: Int = 2
print(constA)

print("这里可以存放一个常量\(a)")     // a是之前已经定义好的一个变量或者常量名

str = "this is a str"
for ch in str {
    print(ch)
}

var arr1 = [Int](repeating: 0, count: 3)
print(arr1)

var arr = [1,3,5]
for item in arr {   // 直接遍历数组中的值
    print(item)
}
for (index, item) in arr.enumerated() { // 同时遍历值和索引
    print("索引\(index)处的值是：\(item)")
}

var dict: [Int:String] = [1: "123",2: "345",4: "7464"]
print(dict[1])
dict.updateValue("新值", forKey: 2)   // 如果key不存在会自动创建，存在则更新值
print(dict[2])
dict[3] = "哈哈"  // 这样赋值就得不到返回值，使用updateValue可以得到一个Optional类型的返回值以便于后续操作
print(dict[3])
var removeResult = dict.removeValue(forKey: 2)  // removeValue会返回被删除的值的Optional类型，键不存在会返回nil
print(removeResult)
dict[3] = nil   // 直接赋值为nil也相当于删除该值，但是没有返回值

for (key, value) in dict {  // 直接使用for..in就可以遍历字典
    print("key值为\(key)，对应的value为\(value)")
}

let keys = dict.keys    // 获取key的数组
print(keys)
let values = dict.values    // 获取value的数组
print(values)

print(dict.count)   // 通过count属性获取key的数量
print(dict.isEmpty) // 通过isEmpty属性获取字典是否为空

func func1(name: String) -> String {
    return "您的名字是：\(name)";
}

print(func1(name: "张三"))

func getMinAndMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0];
    var currentMax = array[0];
    
    for item in array {
        if item > currentMax {
            currentMax = item;
        }
        if item < currentMin {
            currentMin = item;
        }
    }
    return (currentMin, currentMax);
}

var array = [1,3,5,7,9];
let result = getMinAndMax(array: array);
print("最小值是\(result.min)，最大值是\(result.max)")

func outArg(arg1 a: Int) {
    print(a)    // 在程序内部只能使用a进行操作
}

outArg(arg1: 10)    // 在程序外部只能使用arg1进行传值


func argChange(numbers: Int...) {
    for i in numbers {
        print(i)
    }
}
argChange(numbers: 1,2,3,4,5,6)


func changeOutArg(arg1: inout Int, arg2: inout Int) {   // 声明arg1和arg2参数的改变会影响到外部的值
    var temp: Int = arg1;
    arg1 = arg2;
    arg2 = temp;
}
var num1: Int = 4;
var num2: Int = 8;
print(num1);    // 输出4
print(num2);    // 输出8
changeOutArg(arg1: &num1, arg2: &num2);    // 参数被inout声明之后，必须使用&去传递其引用
print(num1);    // 输出8
print(num2);    // 输出4

func sum(a: Int, b: Int) -> Int {
   return a + b;
}
var sumFunc: (Int, Int) -> Int = sum
print(sumFunc(3,4)) // 可以直接使用sumFunc调用函数，这种使用方式有点类似于别名

func sum2(addition: (Int, Int) -> Int, num1: Int, num2: Int) -> Int{    // 定义第一个参数是一个函数类型
    return addition(num1, num2);
}
print(sum2(addition: sumFunc, num1: 5, num2: 7))    // 将sumFunc传递进函数

func getSumFunc(number1: Int, number2: Int) -> (String) -> String { // 返回值是一个函数，如果返回一个无参数的函数，则使用 () -> Xxx即可
    
    func sum(msg: String) -> String{    // 内部函数可以直接使用外部函数的参数
        return msg + "：\(number1 + number2)";
    }
    return sum;
}

var getSum = getSumFunc(number1: 4, number2: 6);    // getSum的类型是一个函数
print(getSum("求和"));    // 使用getSum调用的就是getSumFunc返回的那个函数

let myPrint = {(msg: String) in print(msg)}
myPrint("通过闭包自定义一个print函数")
let getMax = {(a: Int,b: Int) -> Int in // 通过闭包定义一个求最大值的函数
    var result = a;
    if b > a {
        result = b;
    }
    return result;
}
print(getMax(4,9));

let names = ["zhang", "lee", "wang", "zhao"]
func sort(str1: String, str2: String) -> Bool {
    return str1 < str2;
}
var res1 = names.sorted(by: sort)   // 以闭包的形式调用已存在的函数
print(res1) // ["lee", "wang", "zhang", "zhao"]
var res2 = names.sorted(by: {$0 < $1})  // 使用$i代表闭包内参数
print(res2) // ["lee", "wang", "zhang", "zhao"]
var res3 = names.sorted(by: <)      // 某些特殊情况，可以直接把参数也省略
print(res3) // ["lee", "wang", "zhang", "zhao"]
var res4 = names.sorted() {$0 < $1}     // swift支持尾随表达式，即闭包表达式尾随在调用者后面,这种形式无法省略参数
print(res4) // ["lee", "wang", "zhang", "zhao"]
var res5 = names.sorted {$0 < $1}   // 如果调用者只需要一个闭包表达式作为参数，小括号也可以省略
print(res5) // ["lee", "wang", "zhang", "zhao"]

func outFunc(inFunc amount: Int) -> () -> Int {
    var total = 0;
    func inFunc() -> Int {
        total += amount;
        return total;
    }
    return inFunc;
}
let r = outFunc(inFunc: 5)
print(r())  // 输出5
print(r())  // 输出10
print(r())  // 输出15

enum Week {
    case MONDAY
    case TUESDAY
    case WEDNESDAY
    case THURSDAY
    case FRIDAY
    case SATURDAY
    case SUNDAY
}

var day = Week.THURSDAY
//print(day)
func checkWeek(week: Week) {
    switch week {
        case .MONDAY:
            print("周一")
        case .TUESDAY:
            print("周二")
        case .WEDNESDAY:
            print("周三")
        case .THURSDAY:
            print("周四")
        case .FRIDAY:
            print("周五")
        case .SATURDAY:
            print("周六")
        case .SUNDAY:
            print("周日")
        
    }
}

checkWeek(week: day)


enum Student {
    case BaseInfo(name: String, grade: Int)
    case ExamScore(chinese: Int, math: Int, english: Int)
}

var studentInfo = Student.BaseInfo(name: "张三", grade: 23)
var studentScore = Student.ExamScore(chinese: 90, math: 95, english: 85)
switch studentScore {
case .BaseInfo(let name, let grade):
    print("姓名:\(name)，年级：\(grade)")
case .ExamScore(let chinese, let math, let english):
    print("语文成绩：\(chinese)，数学成绩：\(math)，英语成绩：\(english)")
}

enum Month: Int {   // Int用来声明原始值的类型
    case January
    case February
}
print("原始值：\(Month.January.rawValue)")

struct Score {
//    var chinese: Int
//    var math: Int
//    var english: Int
    
    // 定义的时候就初始化，默认会多一个无参的init方法
    var chinese = 100
    var math = 90
    var english = 80
    
//    init(chinese: Int) {    // 如果手动定义int方法，默认的全参init方法就不存在了
//        self.chinese = chinese
//    }
}

let score = Score(chinese: 90, math: 80, english: 70)   // 结构体默认会有一个全参数的init方法
let score1 = Score()    // 这种创建实例的方式只有结构体定义的时候参数就被初始化才能使用
print(score1.chinese)

class student {
    var name: String
    var age: Int
    var score: Double
    
    init(name: String, age: Int, score: Double) {
        self.name = name
        self.age = age
        self.score = score
    }
}
let stu = student(name: "张三", age: 23, score: 45.5)
print(stu.name)     // 输出 张三

struct Number {
    var digits = 222
    let pi = 3.1415
}
var num = Number(digits: 123)
num.digits = 234
// 常量不可改变，修改会报错
//num.pi = 3.14
print(num.digits)
print(num.pi)

class lazySample {
    lazy var n = Number()
}
var ls = lazySample()
print(ls.n.digits)

class calcProp {
    var num1=1.0,num2=2.0
    
    var avg: Double {
        get {
            return (num1 + num2) / 2
        }
        set(n) {
            // 用来主动对属性设置值，一般来说很少用，因为计算属性很少需要主动设置值
            // 没有set的计算属性叫做只读计算属性
        }
    }
}

var calc = calcProp()
print(calc.avg)
calc.avg = 2.0  // 设置avg的值

class Counter {
    var count: Int = 0 {
        willSet(newValue) {
            print("\(count)---\(newValue)")
        }
        didSet {
            // didSet会自动传进一个名字为oldValue的变量，直接取就可以获取旧的值
            print("\(count)---\(oldValue)")
        }
        
    }
}
let counter = Counter()
counter.count = 100


struct StructA {
    static var a = 10
}
print(StructA.a)

class ClassA {
    static var b = 11
    class var count: Int {
        return b;
    }
}
print(ClassA.b)
print(ClassA.count)
