module QuestionBank
  class QuestionsController < QuestionBank::ApplicationController
    def new_single_choice
    end

    def new_bool
    end

    def new_mapping
      @question = Question.new
    end

    def create
      kind = params[:question][:kind]
      hash = send("question_#{kind}_params")
      @question = Question.new(hash)
      if @question.save
        redirect_to questions_path
      else
        redirect_to(send("new_#{kind}_questions_path"))
      end
    end

    private
      def question_bool_params
        params.require(:question).permit(:kind, :content, :bool_answer, :analysis, :level, :enabled)
      end

      def question_single_choice_params
        params.require(:question).permit(:kind, :content, :analysis, :level, :enabled, :choices => [], :choice_answer_indexs => [])
      end

      def question_mapping_params
        new_mapping_answer = []
        params[:question][:mapping_answer].each { |key,value| new_mapping_answer[key.to_i] = value}
        hash = params.require(:question).permit(:kind, :content, :analysis, :level, :enabled)
        hash[:mapping_answer] = new_mapping_answer
        hash
      end

  end
end
