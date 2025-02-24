import { StartOptions } from "@kit.AbilityKit"
import { dateFormat, getRandomDateByCurrentMonth } from "../utils/DateFormat";
import { data } from "@kit.TelephonyKit";

export enum TaskModelStatus {
  //   未完成
  undone = "undone",
  //   完成
  done = "done",
  //   进行中
  doing = "doing",
  //   未来任务
  future = "future",
}

export enum TaskModelType {
  //   个人任务
  personal = "personal",
  //   工作任务
  work = "work",
}

export enum TaskModelTag {
  //  工作
  work = "work",
  //   生活
  life = "life",
  //   学习
  study = "study",
  //   娱乐
  play = "play",
}


export class TaskModel {
  id: string = ""
  taskStatus: TaskModelStatus = TaskModelStatus.undone
  taskName: string = ""
  taskDate: string = ""
  taskStartTime: string = ""
  taskEndTime: string = ""
  taskDetailContent: string = ""
  taskType: TaskModelType = TaskModelType.personal
  taskTag: TaskModelTag = TaskModelTag.work

  constructor(id: string, taskName: string, taskDate: string,
    taskStartTime: string, taskEndTime: string, taskDetailContent: string,
    taskType: TaskModelType,
    taskTag: TaskModelTag
  ) {
    this.id = id
    this.taskName = taskName
    this.taskDate = taskDate
    this.taskStartTime = taskStartTime
    this.taskEndTime = taskEndTime
    this.taskDetailContent = taskDetailContent
    this.taskType = taskType
    this.taskTag = taskTag

    this.taskStatus = TaskModelStatus.undone

    this.updateTaskState()
  }

  updateTaskState() {

    const currentDate: string = dateFormat(new Date(), "yyyy-MM-dd")

    if (this.taskDate > currentDate) {
      this.taskStatus = TaskModelStatus.future
    } else if (this.taskDate === currentDate) {
      this.taskStatus = TaskModelStatus.doing
    } else if (this.taskDate < currentDate) {
      this.taskStatus = TaskModelStatus.undone
    }

  }
}

class CreateTaskListMockData {
  private tasks: Array<TaskModel> = []

  initData() {
    for (let index = 0; index < 30; index++) {

      const randomDate = getRandomDateByCurrentMonth()

      const task = new TaskModel(
        `${index + 1}`,
        `要完成的任务${index + 1}`,
        randomDate,
        "11:30",
        "22:30",
        "这是任务描述",
        TaskModelType.personal,
        TaskModelTag.work,
      )

      this.tasks.push(task)
    }
    return this.tasks
  }
}

export default new CreateTaskListMockData()

