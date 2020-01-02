import 'dart:async';

import 'dart:convert' as convert;

import '../../models/category.dart';
import '../../models/question.dart';

import 'api_interface.dart';

class MockAPI implements QuestionsAPI {
  @override
  Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    categories.addAll([
      Category(id: 1, name: 'Trắc nghiệm sở thích'),
      Category(id: 2, name: 'Trắc nghiệm khả năng'),
      Category(id: 3, name: 'Trắc nghiệm toàn diên'),
    ]);
    print(categories);
    return categories;
  }

  @override
  Future<List<Question>> getQuestions(
      {List<Question> questions,
      int number,
      Category category,
      QuestionDifficulty difficulty,
      QuestionType type}) async {
    const abilityJson = '''"
      { 'response_code' :0,
      'results': [
        {
        'category': 'General Knowledge', 
        'type': 'multiple',
        'difficulty': 'easy', 
        'question': 'Hưng làm việc 45 tiếng một tuần. Tuần trước anh đã làm thêm giờ 17 tiếng. Hưng đã làm bao nhiêu giờ',
          'correct_answer': '28 giờ',
          'incorrect_answers': ['38 giờ','52 giờ','61 giờ','Không câu trả lời nào đúng']
        },
        {
        'category': 'General Knowledge', 
        'type': 'multiple' ,
        'difficulty': 'easy' ,  
        'question': 'Để đến chỗ làm Lan thường mất 45 phút. Sáng nay Lan mất 1 giờ 5 phút. Lan cần thêm bao nhiêu thời gian sáng nay?',
        'correct_answer': '20 phút',
        'incorrect_answers': ['10 phút','30 phút','5 phút','Không câu trả lời nào đúng']
        },
      ]
    }"''';

    const json =
        "{\"response_code\":0,\"results\":[{\"category\":\"General Knowledge\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"330 : 15\",\"correct_answer\":\"22\",\"incorrect_answers\":[\"18\",\"20 \",\"16\"]},{\"category\":\"Science: Mathematics\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"In Roman Numerals, what does XL equate to?\",\"correct_answer\":\"40\",\"incorrect_answers\":[\"60\",\"15\",\"90\"]},{\"category\":\"Entertainment: Television\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"Grant Gustin plays which superhero on the CW show of the same name?\",\"correct_answer\":\"The Flash\",\"incorrect_answers\":[\"The Arrow\",\"Black Canary\",\"Daredevil\"]},{\"category\":\"Entertainment: Cartoon & Animations\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"In the 1993 Disney animated series, what is the name of Bonker\'s second partner?\",\"correct_answer\":\"Miranda Wright\",\"incorrect_answers\":[\"Dick Tracy\",\"Eddie Valiant\",\"Dr. Ludwig von Drake\"]},{\"category\":\"Geography\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"How many countries does Mexico border?\",\"correct_answer\":\"3\",\"incorrect_answers\":[\"2\",\"4\",\"1\"]}]}";

    final jsonResponse = convert.jsonDecode(json);
//    final abilityReponse = convert.jsonDecode(abilityJson);

    final result = (jsonResponse['results'] as List)
        .map((question) => QuestionModel.fromJson(question));

    questions =
        result.map((question) => Question.fromQuestionModel(question)).toList();
    print(questions);
    return questions;
  }
}
