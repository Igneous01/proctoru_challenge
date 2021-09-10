class CollegeExamModel
    attr_accessor :college_id
    attr_accessor :exam_models

    def initialize(college_id, exam_models)
        @college_id = college_id
        @exam_models = exam_models
    end
end
  