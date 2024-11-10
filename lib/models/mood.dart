enum ListMood { sad, angry, happy, disgust, fear, surprise }

class Mood {
  final String moodId;
  final ListMood moodType;

  Mood({
    required this.moodId,
    required this.moodType,
  });

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      moodId: json['moodId'] as String,
      moodType: ListMood.values.firstWhere(
        (e) => e.toString().split('.').last == json['moodType'],
        orElse: () => ListMood.happy,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moodId': moodId,
      'moodType': moodType.toString().split('.').last,
    };
  }
}
