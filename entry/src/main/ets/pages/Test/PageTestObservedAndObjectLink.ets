//
// //  嵌套对象
// // objectLinkNestedObjects.ets
// let NextID: number = 1;
//
// @Observed
// class Bag {
//   public id: number;
//   public size: number;
//
//   constructor(size: number) {
//     this.id = NextID++;
//     this.size = size;
//   }
// }
//
// @Observed
// class User {
//   public bag: Bag;
//
//   constructor(bag: Bag) {
//     this.bag = bag;
//   }
// }
//
// @Observed
// class Book {
//   public bookName: BookName;
//
//   constructor(bookName: BookName) {
//     this.bookName = bookName;
//   }
// }
//
// @Observed
// class BookName extends Bag {
//   public nameSize: number;
//
//   constructor(nameSize: number) {
//     // 调用父类方法对nameSize进行处理
//     super(nameSize);
//     this.nameSize = nameSize;
//   }
// }
//
// @Component
// struct Son {
//   label: string = 'Son';
//   @ObjectLink bag: Bag;
//
//   build() {
//     Column() {
//       Text(`Son [${this.label}] this.bag.size = ${this.bag.size}`)
//         .fontColor('#ffffffff')
//         .backgroundColor('#ff3d9dba')
//         .width(320)
//         .height(50)
//         .borderRadius(25)
//         .margin(10)
//         .textAlign(TextAlign.Center)
//       Button(`Son: this.bag.size add 1`)
//         .width(320)
//         .backgroundColor('#ff17a98d')
//         .margin(10)
//         .onClick(() => {
//           this.bag.size += 1;
//         })
//     }
//   }
// }
//
// @Component
// struct Father {
//   label: string = 'Father';
//   @ObjectLink bookName: BookName;
//
//   build() {
//     Row() {
//       Column() {
//         Text(`Father [${this.label}] this.bookName.size = ${this.bookName.size}`)
//           .fontColor('#ffffffff')
//           .backgroundColor('#ff3d9dba')
//           .width(320)
//           .height(50)
//           .borderRadius(25)
//           .margin(10)
//           .textAlign(TextAlign.Center)
//         Button(`Father: this.bookName.size add 1`)
//           .width(320)
//           .backgroundColor('#ff17a98d')
//           .margin(10)
//           .onClick(() => {
//             this.bookName.size += 1;
//             console.log('this.bookName.size:' + this.bookName.size);
//           })
//       }
//       .width(320)
//     }
//   }
// }
//
// @Entry
// @Component
// struct GrandFather {
//   @State user: User = new User(new Bag(0));
//   @State child: Book = new Book(new BookName(0));
//
//   build() {
//     Column() {
//       Son({ label: 'Son #1', bag: this.user.bag })
//         .width(320)
//       Father({ label: 'Father #3', bookName: this.child.bookName })
//         .width(320)
//       Button(`GrandFather: this.child.bookName.size add 10`)
//         .width(320)
//         .backgroundColor('#ff17a98d')
//         .margin(10)
//         .onClick(() => {
//           this.child.bookName.size += 10;
//           console.log('this.child.bookName.size:' + this.child.bookName.size);
//         })
//       Button(`GrandFather: this.user.bag = new Bag(10)`)
//         .width(320)
//         .backgroundColor('#ff17a98d')
//         .margin(10)
//         .onClick(() => {
//           this.user.bag = new Bag(10);
//         })
//       Button(`GrandFather: this.user = new User(new Bag(20))`)
//         .width(320)
//         .backgroundColor('#ff17a98d')
//         .margin(10)
//         .onClick(() => {
//           this.user = new User(new Bag(20));
//         })
//     }
//   }
// }

// 对象数组
//
// let NextID: number = 1;
//
// @Observed
// class Info {
//   public id: number;
//   public info: number;
//
//   constructor(info: number) {
//     this.id = NextID++;
//     this.info = info;
//   }
// }
//
// @Component
// struct Child {
//   // 子组件Child的@ObjectLink的类型是Info
//   @ObjectLink info: Info;
//   label: string = 'ViewChild';
//
//   build() {
//     Row() {
//       Button(`ViewChild [${this.label}] this.info.info = ${this.info ? this.info.info : "undefined"}`)
//         .width(320)
//         .margin(10)
//         .onClick(() => {
//           this.info.info += 1;
//         })
//     }
//   }
// }

// @Entry
// @Component
// struct Parent {
//   // Parent中有@State装饰的Info[]
//   @State arrA: Info[] = [new Info(0), new Info(0)];
//
//   build() {
//     Column() {
//       ForEach(this.arrA,
//         (item: Info) => {
//           Child({ label: `#${item.id}`, info: item })
//         },
//         (item: Info): string => item.id.toString()
//       )
//       // 使用@State装饰的数组的数组项初始化@ObjectLink，其中数组项是被@Observed装饰的Info的实例
//       Child({ label: `ViewChild this.arrA[first]`, info: this.arrA[0] })
//       Child({ label: `ViewChild this.arrA[last]`, info: this.arrA[this.arrA.length-1] })
//
//       Button(`ViewParent: 第一个子组件的info${ this.arrA[0].info}}`)
//         .width(320)
//         .margin(10)
//         .onClick(() => {
//           this.arrA = [new Info(0), new Info(0)];
//         })
//
//
//       Button(`ViewParent: reset array`)
//         .width(320)
//         .margin(10)
//         .onClick(() => {
//           this.arrA = [new Info(0), new Info(0)];
//         })
//       Button(`ViewParent: push`)
//         .width(320)
//         .margin(10)
//         .onClick(() => {
//           this.arrA.push(new Info(0));
//         })
//       Button(`ViewParent: shift`)
//         .width(320)
//         .margin(10)
//         .onClick(() => {
//           if (this.arrA.length > 0) {
//             this.arrA.shift();
//           } else {
//             console.log("length <= 0");
//           }
//         })
//       Button(`ViewParent: item property in middle`)
//         .width(320)
//         .margin(10)
//         .onClick(() => {
//           this.arrA[Math.floor(this.arrA.length / 2)].info = 10;
//         })
//       Button(`ViewParent: item property in middle`)
//         .width(320)
//         .margin(10)
//         .onClick(() => {
//           this.arrA[Math.floor(this.arrA.length / 2)] = new Info(11);
//         })
//     }
//   }
// }

@Observed
class Info {
  public info: number = 0;

  constructor(info: number) {
    this.info = info;
  }
}

@Component
struct ObjectLinkChild {
  @ObjectLink testNum: Info;

  build() {
    Text(`ObjectLinkChild testNum ${this.testNum.info}`)
      .onClick(() => {
        // 可以对ObjectLink装饰对象的属性赋值
        this.testNum.info = 47;
      })
  }
}

@Entry
@Component
struct Parent {
  @State testNum: Info[] = [new Info(1)];

  build() {
    Column() {
      Text(`Parent testNum ${this.testNum[0].info}`)
        .onClick(() => {
          this.testNum[0].info += 1;
        })

      ObjectLinkChild({ testNum: this.testNum[0] })
    }
  }
}