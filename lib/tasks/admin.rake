namespace :admin do
  desc "Create an admin with email, password"
  task :create, [:email, :password] => :environment do |t, args|
    unless args.email
      puts 'Error: should type an email'
      exit
    end
    unless args.password
      puts 'Error: should type a password'
      exit
    end

    employee = Employee.create! email: args.email,
                        password: args.password,
                        password_confirmation: args.password
    employee.is_system_admin = true
    employee.save!
    puts '[done]'
  end

  desc "Delete an employee in DB"
  task :delete, [:email]  => :environment do |t, args|
    unless args.email
      puts 'should type an email for the employee'
      exit
    end

    employee = Employee.where(email: args.email).first

    if employee.nil?
      puts "employee #{args.email} does not exist"
      exit
    end

    name = employee.nickname
    Employee.destroy employee unless employee.nil?
    puts "employee #{name} has been removed"

  end

end
