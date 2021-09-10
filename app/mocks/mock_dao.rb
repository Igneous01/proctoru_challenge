class MockDao

    def initialize
        @users = [
            StudentModel.new("Fred", "James", "222-444-0101"),
            StudentModel.new("Jane", "Hamelin", "1-444-123-0404"),
            StudentModel.new("Dave", "Cameron", "444-987-0134")
        ]
        @college_exams = [
            CollegeExamModel.new(313, 
                [
                    ExamModel.new(123, DateTime.new(2021,9,9,4,0,0), DateTime.new(2021,9,9,4,30,0)), 
                    ExamModel.new(444, DateTime.new(2021,9,11,9,30,0), DateTime.new(2021,9,11,10,0,0)),
                    ExamModel.new(938, DateTime.new(2021,9,14,14,0,0), DateTime.new(2021,9,14,15,0,0))
                ]),
            CollegeExamModel.new(414, 
                [
                    ExamModel.new(59135, DateTime.new(2021,9,12,18,0,0), DateTime.new(2021,9,12,18,10,0)), 
                ]),
            CollegeExamModel.new(111, 
                [
                    ExamModel.new(12358, DateTime.new(2021,9,13,20,30,0), DateTime.new(2021,9,13,20,45,0))
                ])
        ]
    end

    def find_college(college_id)
        return @college_exams.detect {|c| c.college_id == college_id}
    end

    def find_exam(college_id, exam_id) 
        college = find_college(college_id)
        if (!college.nil?)
            return college.exam_models.detect {|e| e.exam_id == exam_id}
        else
            return nil
        end
    end

    def find_user(first_name, last_name)
        return @users.detect {|e| e.first_name == first_name && e.last_name == last_name}
    end

    def exam_window_open(college_id, exam_id, registration_time)
        college = find_college(college_id)
        if (!college.nil?)
            exam = college.exam_models.detect {|e| e.exam_id == exam_id}
            if (!exam.nil?)
                return registration_time >= exam.start_time && registration_time <= exam.end_time
            else
                return false
            end
        else
            return false
        end
    end

    def create_user(first_name, last_name, phone_number)
        # Mock failure
        if (first_name == "err")
            raise "Failed to create user because of an internal server error"
        end
        if (find_user(first_name, last_name).nil?)
            @users.append(UserModel.new(first_name,last_name,phone_number))
        end
    end
end