import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/core/classes/images_manager.dart';
import 'package:mobile_app/core/classes/my_logger.dart';
import 'package:mobile_app/features/shared%20copy/widgets/snackbar.dart';

Future<XFile?> pickImageFromUi(XFile? xfile) async {
  final file = await ImagesManager.pickImage(ImageSource.gallery);
  if (file != null) {
    xfile = file;
  }
  if (xfile != null) {
    MyLogger.instance.printLog("picked image success");
    return xfile;
  } else {
    AppSnackBar.show("no picked image ", type: SnackBarType.error);
    MyLogger.instance.printLog("no picked image");
  }
  return null;
}
