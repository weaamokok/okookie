import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<List<PlatformFile>?> selectOrTakePhoto(ImageSource imageSource) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.image,
    
  );
  if (result == null) {
    return null;
  }
  return result.files;
}
