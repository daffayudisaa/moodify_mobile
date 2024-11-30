List<Map<String, String>> filterSongsByMood(
  String selectedMood,
  List<String> displayMoods,
  Map<String, List<Map<String, String>>> songsByMood,
) {
  if (selectedMood == 'All') {
    List<Map<String, String>> allSongs = [];
    for (var mood in displayMoods) {
      if (mood != 'All') {
        allSongs.addAll(songsByMood[mood] ?? []);
      }
    }
    return allSongs;
  } else {
    return songsByMood[selectedMood] ?? [];
  }
}
