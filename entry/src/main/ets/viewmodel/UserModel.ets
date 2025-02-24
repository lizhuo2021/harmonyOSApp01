@Observed
export class UserModel {
  id: string = ""
  name: string = ""
  car: Car = new Car("", "", 0)

  constructor(id: string, name: string, car: Car) {
    this.id = id
    this.name = name
    this.car = car
  }
}

@Observed
export class Car {
  carID: string = ""
  carName: string = ""
  carNumber: number = 0

  constructor(carID: string, carName: string, carNumber: number) {
    this.carID = carID
    this.carName = carName
    this.carNumber = carNumber
  }

}