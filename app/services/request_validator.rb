class RequestValidator

    def initialize(dao)
        @dao = dao
    end

    def validate(params)
        begin
            params[:college_id].to_i 
        rescue e 
            return [false, "college_id is not a valid integer"]
        end

        begin
            params[:exam_id].to_i 
        rescue e 
            return [false, "exam_id is not a valid integer"]
        end

        begin
            datetime = DateTime.parse(params[:start_time])
            puts datetime
        rescue e
            return [false, "start_time could not be parsed into valid date"]
        end

        if (@dao.find_college(params[:college_id].to_i).nil?)
            return [false, "Invalid college_id"]
        elsif (@dao.find_exam(params[:college_id].to_i, params[:exam_id].to_i).nil?)
            return [false, "Invalid exam_id for this college_id"]
        elsif (!@dao.exam_window_open(params[:college_id].to_i, params[:exam_id].to_i, DateTime.parse(params[:start_time])))
            return [false, "The registration window for this exam is closed"]
        else
            return [true, "Valid exam registration"]
        end
    end
end