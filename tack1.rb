require 'date'

class Student
  attr_accessor :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = date_of_birth

    raise ArgumentError, "Date of birth must be in the past" if date_of_birth >= Date.today

    add_student(self)
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth + age * 365
    age
  end

  def add_student(student)
    unless @@students.any? { |s| s.name == student.name && s.surname == student.surname && s.date_of_birth == student.date_of_birth }
      @@students << student
    end
  end

  def remove_student
    @@students.delete(self)
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end


  def self.all_students
    @@students
  end
end

require 'date'

student1 = Student.new("Smith", "John", Date.new(2000, 5, 15))
student2 = Student.new("Doe", "Jane", Date.new(1998, 8, 20))
student3 = Student.new("Smith", "John", Date.new(2000, 5, 15)) 

puts "Список студентів після додавання:"
Student.all_students.each do |student|
  puts "#{student.name} #{student.surname}, Дата народження: #{student.date_of_birth}"
end

puts "\nВік студента #{student1.name} #{student1.surname}: #{student1.calculate_age} років"

student1.remove_student
puts "\nСписок студентів після видалення студент1:"
Student.all_students.each do |student|
  puts "#{student.name} #{student.surname}, Дата народження: #{student.date_of_birth}"
end

puts "\nСтуденти віком 26 років:"
students_age_26 = Student.get_students_by_age(26)
students_age_26.each do |student|
  puts "#{student.name} #{student.surname}, Дата народження: #{student.date_of_birth}"
end


puts "\nСтуденти з іменем 'Jane':"
students_named_jane = Student.get_students_by_name("Jane")
students_named_jane.each do |student|
  puts "#{student.name} #{student.surname}, Дата народження: #{student.date_of_birth}"
end
