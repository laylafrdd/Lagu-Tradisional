import 'package:audio_player/controlButton.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audio_player/common.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayer1Screens extends StatefulWidget {
  @override
  _AudioPlayer1ScreensState createState() => _AudioPlayer1ScreensState();
}

class _AudioPlayer1ScreensState extends State<AudioPlayer1Screens> {
  late AudioPlayer _player;
  final _playlist = ConcatenatingAudioSource(children: [
    ClippingAudioSource(
      start: Duration(seconds: 60),
      end: Duration(seconds: 90),
      child: AudioSource.uri(Uri.parse("asset:///assets/audio/Lagu1.mp3")),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/1.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu1.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/1.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu2.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/2.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu1.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/3.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu2.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/4.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu1.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/5.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu2.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/6.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu1.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/7.png",
      ),
    ),
    AudioSource.uri(
      Uri.parse("asset:///assets/audio/Lagu2.mp3"),
      tag: AudioMetadata(
        album: "Lagu Daerah Suku Ketengban",
        title: "Lagu masyarakat ketengban wilayah bame dengan dialek bame",
        artwork: "assets/images/8.png",
      ),
    ),
  ]);

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      // Catch load errors: 404, invalid url...
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<SequenceState?>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) return SizedBox();
                    final metadata = state!.currentSource!.tag as AudioMetadata;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Center(child: Image.asset(metadata.artwork)),
                          ),
                        ),
                        Text(metadata.album,
                            style: Theme.of(context).textTheme.headline6),
                        Text(metadata.title),
                      ],
                    );
                  },
                ),
              ),
              ControlButtons(_player),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: (newPosition) {
                      _player.seek(newPosition);
                    },
                  );
                },
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  StreamBuilder<LoopMode>(
                    stream: _player.loopModeStream,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.off;
                      const icons = [
                        Icon(Icons.repeat, color: Colors.grey),
                        Icon(Icons.repeat, color: Colors.orange),
                        Icon(Icons.repeat_one, color: Colors.orange),
                      ];
                      const cycleModes = [
                        LoopMode.off,
                        LoopMode.all,
                        LoopMode.one,
                      ];
                      final index = cycleModes.indexOf(loopMode);
                      return IconButton(
                        icon: icons[index],
                        onPressed: () {
                          _player.setLoopMode(cycleModes[
                              (cycleModes.indexOf(loopMode) + 1) %
                                  cycleModes.length]);
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Playlist",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: _player.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: shuffleModeEnabled
                            ? Icon(Icons.shuffle, color: Colors.orange)
                            : Icon(Icons.shuffle, color: Colors.grey),
                        onPressed: () async {
                          final enable = !shuffleModeEnabled;
                          if (enable) {
                            await _player.shuffle();
                          }
                          await _player.setShuffleModeEnabled(enable);
                        },
                      );
                    },
                  ),
                ],
              ),
              Container(
                height: 240.0,
                child: StreamBuilder<SequenceState?>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    final sequence = state?.sequence ?? [];
                    return ReorderableListView(
                      onReorder: (int oldIndex, int newIndex) {
                        if (oldIndex < newIndex) newIndex--;
                        _playlist.move(oldIndex, newIndex);
                      },
                      children: [
                        for (var i = 0; i < sequence.length; i++)
                          Dismissible(
                            key: ValueKey(sequence[i]),
                            background: Container(
                              color: Colors.redAccent,
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            onDismissed: (dismissDirection) {
                              _playlist.removeAt(i);
                            },
                            child: Material(
                              color: i == state!.currentIndex
                                  ? Colors.grey.shade300
                                  : null,
                              child: ListTile(
                                title: Text(sequence[i].tag.title as String),
                                onTap: () {
                                  _player.seek(Duration.zero, index: i);
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     _playlist.add(AudioSource.uri(
        //       Uri.parse("asset:///audio/nature.mp3"),
        //       tag: AudioMetadata(
        //         album: "Public Domain",
        //         title: "Nature Sounds ${++_addedCount}",
        //         artwork:
        //             "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
        //       ),
        //     ));
        //   },
        // ),
      
    );
  }
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata({
    required this.album,
    required this.title,
    required this.artwork,
  });
}
