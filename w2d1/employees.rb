class Employee
  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
    @boss = nil
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary)
    @employees = []
    super
  end

  def assign_employeee(employee)
    self.employees << employee
    employee.boss = self
  end

  def total_sub_salary
    res = 0
    employees.each do |employee|
      if employee.is_a?(Manager)
        res += employee.salary + employee.total_sub_salary
      else
        res += employee.salary
      end
    end
    res
  end

  def bonus(multiplier)
    total_sub_salary * multiplier
  end

end

david = Employee.new("David", "TA", 10000)
shawna = Employee.new("Shawna", "TA", 12000)
darren = Manager.new("Darren", "TA Manager", 78000)
darren.assign_employeee(david)
darren.assign_employeee(shawna)
ned = Manager.new("Ned", "Founder", 1000000)
ned.assign_employeee(darren)

puts ned.bonus(5) # => 500_000
puts darren.bonus(4) # => 88_000
puts david.bonus(3) # => 30_000
