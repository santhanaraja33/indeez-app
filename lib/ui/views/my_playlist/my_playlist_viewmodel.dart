import 'package:music_app/ui/data/bean/model/gridview_model.dart';
import 'package:stacked/stacked.dart';

class MyPlaylistViewModel extends BaseViewModel {
  final gridviewModel = [
    GridViewModels(
      'Top 5',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums1.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Swiped Like',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums2.jpg',
      '',
      '',
      '',
    ),
    GridViewModels(
      'Some other playlist',
      'https://indeez.1cczywc7sm4y.us-south.codeengine.appdomain.cloud/4albums3.jpg',
      '',
      '',
      '',
    ),
  ];
}
