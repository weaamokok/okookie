import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:okookie/domain/cookie.dart';
import 'package:okookie/features/control_panel/control_panel_deps.dart';
import 'package:okookie/features/control_panel/main_control_screen.dart';
import 'package:okookie/helpers/image_picker.dart';
import 'package:okookie/main.dart';
import 'package:textfield_tags/textfield_tags.dart';

final GlobalKey<FormState> formKey = GlobalKey(debugLabel: 'addItemKey');

@RoutePage()
class AddItemScreen extends StatefulHookConsumerWidget {
  const AddItemScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddItemScreen();
}

class _AddItemScreen extends ConsumerState<AddItemScreen>
    with WidgetsBindingObserver {
  late double _distanceToField;
  late StringTagController _stringTagController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final itemName = TextEditingController();
    final itemDescription = TextEditingController();
    final itemPrice = TextEditingController();
    final itemStock = TextEditingController();
    final colorScheme = ref.read(appThemeProvider).colorScheme;
    final isLoading = useState(false);
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ref.read(appThemeProvider).colorScheme.onSurfaceVariant)),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add A Goodness',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ), //todo add hint to local
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: itemName,
                          style: TextStyle(fontSize: 13),
                          decoration: const InputDecoration(
                            hintText: 'item name',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 5,
                        controller: itemDescription,
                        style: TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'description',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ), //this field should be generated base on currencies available
                      TextFormField(
                        controller: itemPrice,
                        style: TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          suffix: Text('USD'), //todo make this dynamic
                          suffixStyle: TextStyle(color: Colors.grey),
                          hintText: 'price',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: itemStock,
                        style: TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'stock quantity',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldTags<String>(
                        textfieldTagsController: _stringTagController,
                        textSeparators: const [' ', ','],
                        letterCase: LetterCase.normal,
                        validator: (String tag) {
                          if (_stringTagController.getTags!.contains(tag)) {
                            return 'You\'ve already entered that';
                          }
                          return null;
                        },
                        inputFieldBuilder: (context, inputFieldValues) {
                          return TextField(
                            onTap: () {
                              _stringTagController.getFocusNode?.requestFocus();
                            },
                            style: TextStyle(fontSize: 13),
                            controller: inputFieldValues.textEditingController,
                            focusNode: inputFieldValues.focusNode,
                            decoration: InputDecoration(
                              isDense: true,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 74, 137, 92),
                                  width: 3.0,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 74, 137, 92),
                                  width: 3.0,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              hintText: inputFieldValues.tags.isNotEmpty
                                  ? ''
                                  : "ingredients",
                              errorText: inputFieldValues.error,
                              prefixIconConstraints: BoxConstraints(
                                  maxWidth: _distanceToField * 0.8),
                              prefixIcon: inputFieldValues.tags.isNotEmpty
                                  ? SingleChildScrollView(
                                      controller:
                                          inputFieldValues.tagScrollController,
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 8,
                                        ),
                                        child: Wrap(
                                            runSpacing: 4.0,
                                            spacing: 4.0,
                                            children: inputFieldValues.tags
                                                .map((String tag) {
                                              return Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  color: Color.fromARGB(
                                                      255, 74, 137, 92),
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        '#$tag',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onTap: () {
                                                        //print("$tag selected");
                                                      },
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    InkWell(
                                                      child: const Icon(
                                                        Icons.cancel,
                                                        size: 14.0,
                                                        color: Color.fromARGB(
                                                            255, 233, 233, 233),
                                                      ),
                                                      onTap: () {
                                                        inputFieldValues
                                                            .onTagRemoved(tag);
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList()),
                                      ),
                                    )
                                  : null,
                            ),
                            onChanged: inputFieldValues.onTagChanged,
                            onSubmitted: inputFieldValues.onTagSubmitted,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: InkWell(
                    onTap: () async {
                      if(kIsWeb)
                      await selectOrTakePhoto(ImageSource.gallery)
                          .then((image) async {});
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          color: colorScheme.onSurfaceVariant.withOpacity(.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera,
                            color: colorScheme.onSurface,
                          ),
                          Text(
                            'upload item image ',
                            style: TextStyle(
                                fontSize: 12, color: colorScheme.onSurface),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OButton(
                    text: 'cancel',
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    action: () {
                      context.router.maybePop();
                    }),
                const SizedBox(
                  width: 12,
                ),
                OButton(
                  text: 'save',
                  loadingState: isLoading,
                  action: () async {
                    isLoading.value = true;
                    final isValidForm =
                        formKey.currentState?.validate() ?? false;
                    if (!isValidForm) {
                      isLoading.value = false;
                      return;
                    }
                    final cookie = Cookie(
                        name: itemName.text,
                        price: Price(
                          currency: "USD",
                          value: double.tryParse(itemPrice.text) ?? 0.0,
                        ),
                        description: itemDescription.text,
                        ingredients: _stringTagController.getTags,
                        stock: int.tryParse(itemStock.text));
                    print('arg--> $cookie');

                    await ref
                        .read(ControlPanelDeps.addCookieProvider
                            .call(cookie)
                            .future)
                        .whenComplete(
                      () {
                        isLoading.value = false;
                        context.router.maybePop();
                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
