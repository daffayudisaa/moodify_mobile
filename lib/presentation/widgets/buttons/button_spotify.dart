import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class button_spotify extends StatefulWidget {
  const button_spotify({
    super.key,
    required this.getFontSize,
  });

  final double getFontSize;

  @override
  State<button_spotify> createState() => _button_spotifyState();
}

class _button_spotifyState extends State<button_spotify> {
  bool _connected = false;
  String? _accessToken;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: SpotifySdk.subscribeConnectionStatus(),
        builder: (context, snapshot) {
          _connected = false;
          var data = snapshot.data;
          if (data != null) {
            _connected = data.connected;
          }
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: getAccessToken,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: const BorderSide(
                    color: Color.fromRGBO(38, 50, 56, 0.4),
                    width: 0.3,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    height: 20,
                    width: 20,
                    image: AssetImage('assets/images/Spotify-Black.png'),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Spotify",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: widget.getFontSize * 1.05,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> getAccessToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
        clientId: dotenv.env['CLIENT_ID']!,
        redirectUrl: dotenv.env['REDIRECT_URL']!,
        scope: dotenv.env['SPOTIFY_GLOBAL_SCOPE']!,
      );
      setState(() {
        _accessToken = authenticationToken;
      });

      if (_accessToken != null && _accessToken!.isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/navbar');
      }
    } on PlatformException catch (e) {
      setState(() {
        _accessToken = '$e.code: ${e.message}';
      });

      showErrorAndRedirect('Invalid token. Please try again.');
    } on MissingPluginException {
      setState(() {
        _accessToken = 'not implemented';
      });

      showErrorAndRedirect('Feature not implemented.');
    } catch (e) {
      setState(() {
        _accessToken = 'Unexpected error: $e';
      });

      showErrorAndRedirect('An unexpected error occurred.');
    }
  }

  void showErrorAndRedirect(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    Navigator.pushReplacementNamed(context, '/sign-in');
  }
}
