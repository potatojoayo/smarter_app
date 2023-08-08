import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final businessRegistrationNumberFormatter = MaskTextInputFormatter(
    mask: '### - ## - #####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);
