// Logic of App - BLOC Todo
/*
1. imports
2. List of Employees
3. Stream controllers
4. Stream Sink getter
5. Constructor - add data, Listen to changes
6. Core Functions
7. Dispose
*/

import 'dart:async';
import 'Employee.dart';

class EmployeeBLoc {
  // sink : to add in pipe
  // stream : to get data from pipe
  // by pipe means : data flow

  // Created the objects
  List<Employee> _employeeList = [
    Employee(1, 'Poorkar', 100000.0),
    Employee(2, 'Mishra', 300000.0),
    Employee(3, 'Samrat', 1000000.0),
    Employee(4, 'Harry', 400000.0),
    Employee(5, 'Shubham ', 600000.0),
  ];

  // Opening up the Stream Controllers
  final _employeeListStreamController = StreamController<List<Employee>>();

  // for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  // COnstructor
  EmployeeBLoc() {
    _employeeListStreamController.add(_employeeList);

    // Listen to the changes
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }
  // Core Functions
  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incerementedSalary = salary * 0.20;

    _employeeList[employee.id - 1].salary = salary + incerementedSalary;

    // Add to the Sink
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 0.20;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;

    // Add to the Sink
    employeeListSink.add(_employeeList);
  }

  // Dispose : Closing the streams
  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
