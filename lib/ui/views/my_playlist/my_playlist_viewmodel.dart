import 'package:music_app/ui/data/bean/model/gridview_model.dart';
import 'package:stacked/stacked.dart';

class MyPlaylistViewModel extends BaseViewModel {
  final gridviewModel = [
    GridViewModels(
      'Top 5',
      'assets/images/allrock.jpeg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Swiped Like',
      'assets/images/piano.jpeg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Some other playlist',
      'assets/images/collage-pink-tape.jpeg',
      '',
      '',
      '',
    ),
  ];
}
