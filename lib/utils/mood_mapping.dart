final Map<String, List<String>> moodMapping = {
  'sad': ['Sad', 'Calm'],
  'disgust': ['Energetic', 'Happy'],
  'angry': ['Energetic', 'Calm'],
  'fear': ['Happy', 'Calm'],
  'happy': ['Happy', 'Calm'],
  'surprise': ['Energetic', 'Sad'],
  '': ['Happy', 'Sad', 'Calm', 'Energetic']
};

final Map<String, List<Map<String, String>>> songsByMood = {
  'Sad': [
    {'title': 'Someone Like You', 'artist': 'Adele', 'duration': '4:45'},
    {'title': 'Hurt', 'artist': 'Johnny Cash', 'duration': '3:38'},
    {'title': 'Fix You', 'artist': 'Coldplay', 'duration': '4:55'},
    {'title': 'The Night We Met', 'artist': 'Lord Huron', 'duration': '3:28'},
    {'title': 'Everybody Hurts', 'artist': 'R.E.M.', 'duration': '5:20'},
    {
      'title': 'When I Was Your Man',
      'artist': 'Bruno Mars',
      'duration': '3:33'
    },
    {'title': 'Let Her Go', 'artist': 'Passenger', 'duration': '4:12'},
    {'title': 'Back to December', 'artist': 'Taylor Swift', 'duration': '4:55'},
    {'title': 'All I Want', 'artist': 'Kodaline', 'duration': '5:05'},
    {'title': 'Tears in Heaven', 'artist': 'Eric Clapton', 'duration': '4:36'},
  ],
  'Calm': [
    {'title': 'Weightless', 'artist': 'Marconi Union', 'duration': '8:08'},
    {'title': 'Clair de Lune', 'artist': 'Debussy', 'duration': '5:13'},
    {'title': 'Better Together', 'artist': 'Jack Johnson', 'duration': '3:27'},
    {'title': 'Beyond', 'artist': 'Leon Bridges', 'duration': '4:00'},
    {'title': 'Bloom', 'artist': 'The Paper Kites', 'duration': '3:30'},
    {'title': 'Holocene', 'artist': 'Bon Iver', 'duration': '5:36'},
    {'title': 'Sea of Love', 'artist': 'Cat Power', 'duration': '2:20'},
    {'title': 'River Flows in You', 'artist': 'Yiruma', 'duration': '3:41'},
    {'title': 'I’m Yours', 'artist': 'Jason Mraz', 'duration': '4:02'},
    {'title': 'Put It All On Me', 'artist': 'Ed Sheeran', 'duration': '3:37'},
  ],
  'Energetic': [
    {
      'title': 'Can’t Stop the Feeling!',
      'artist': 'Justin Timberlake',
      'duration': '3:56'
    },
    {
      'title': 'Uptown Funk',
      'artist': 'Mark Ronson ft. Bruno Mars',
      'duration': '4:30'
    },
    {
      'title': 'Shut Up and Dance',
      'artist': 'WALK THE MOON',
      'duration': '3:19'
    },
    {'title': 'Happy', 'artist': 'Pharrell Williams', 'duration': '3:53'},
    {'title': 'Stronger', 'artist': 'Kanye West', 'duration': '5:11'},
    {'title': 'Wake Me Up', 'artist': 'Avicii', 'duration': '4:07'},
    {'title': 'We Will Rock You', 'artist': 'Queen', 'duration': '2:02'},
    {
      'title': 'I Gotta Feeling',
      'artist': 'Black Eyed Peas',
      'duration': '4:49'
    },
    {'title': 'Eye of the Tiger', 'artist': 'Survivor', 'duration': '4:04'},
    {'title': 'Don’t Stop Believin’', 'artist': 'Journey', 'duration': '4:10'},
  ],
  'Happy': [
    {
      'title': 'Best Day of My Life',
      'artist': 'American Authors',
      'duration': '3:14'
    },
    {'title': 'Shake It Off', 'artist': 'Taylor Swift', 'duration': '3:39'},
    {
      'title': 'On Top of the World',
      'artist': 'Imagine Dragons',
      'duration': '3:12'
    },
    {
      'title': 'Walking on Sunshine',
      'artist': 'Katrina and the Waves',
      'duration': '3:43'
    },
    {
      'title': 'What Makes You Beautiful',
      'artist': 'One Direction',
      'duration': '3:18'
    },
    {'title': 'Good Life', 'artist': 'OneRepublic', 'duration': '4:13'},
    {'title': 'Sunroof', 'artist': 'Nicky Youre & Dazy', 'duration': '2:43'},
    {'title': 'Classic', 'artist': 'MKTO', 'duration': '2:55'},
    {'title': 'Beautiful Day', 'artist': 'U2', 'duration': '4:08'},
    {'title': 'All Star', 'artist': 'Smash Mouth', 'duration': '3:20'},
  ],
};
