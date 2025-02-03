
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

Future<XFile?> selectOrTakePhoto(ImageSource imageSource) async {
  final img = await ImagePicker.platform
      .getImageFromSource(source: ImageSource.gallery);

  if (img == null) return null;
  return XFile(img.path);
}
