class ExamModel
    attr_accessor :exam_id
    attr_accessor :start_time
    attr_accessor :end_time

    def initialize(exam_id, start_time, end_time)
        @exam_id = exam_id
        @start_time = start_time
        @end_time = end_time
    end
end