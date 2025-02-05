
import 'package:image_picker/image_picker.dart';

Future<XFile?> selectOrTakePhoto(ImageSource imageSource) async {
  final img = await ImagePicker.platform
      .getImageFromSource(source: ImageSource.gallery);

  if (img == null) return null;
  return XFile(img.path);
}
