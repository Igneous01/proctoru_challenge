class MockDao

    def initialize
        @users = [
            UserModel.new("Fred", "James", "222-444-0101"),
            UserModel.new("Jane", "Hamelin", "1-444-123-0404"),
            UserModel.new("Dave", "Cameron", "444-987-0134")
        ]
        @college_exams = [
            CollegeExamModel.new(313, [123, 444, 938]),
            CollegeExamModel.new(414, [59135]),
            CollegeExamModel.new(111, [12358, 183483, 31484])
        ]
    end

    def find_exam(college_id, exam_id) 
        return @college_exams.detect {|e| e == exam_id}
    end

    def find_user(first_name, last_name)
        return @users.detect {|e| e.first_name == first_name && e.last_name == last_name}
    end
end