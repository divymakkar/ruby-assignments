require 'faker'
require 'csv'

class EmailCSV 
    @@email_state = ['delivered','bounced','sent','opened','failed']
    def generateData
        CSV.open('email.csv', 'wb') do |csv|
            for i in 0..10 
                email = Faker::Internet.email
                state = @@email_state.sample
                csv << [email,state]
            end
        end
        segregateEmails
    end

    def segregateEmails
        file = CSV.read('email.csv')
        result = @@email_state.map do |state|
            CSV.open("output/#{state}.csv",'wb')
        end
        file.each do |row|
            state = row[1]
            @@email_state.each_index do |idx|
                if state == @@email_state[idx] 
                    result[idx] << row
                end
            end
        end
        print result
    end
end
EmailCSV.new.generateData