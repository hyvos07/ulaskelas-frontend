part of '_widgets.dart';

/// Taken from this [outdated package](https://github.com/jagan999/dropdownfield/blob/master/lib/dropdownfield.dart)
class DropDownField extends FormField<String> {
  final dynamic value;
  final Widget? icon;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final List<dynamic>? items;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldSetter<dynamic>? setter;
  final ValueChanged<dynamic>? onValueChanged;
  final bool strict;
  final int itemsVisibleInDropdown;
  final TextEditingController? controller;
  final void Function() onValidate;

  DropDownField({
    required this.onValidate,
    this.controller,
    this.value,
    this.icon,
    this.hintText,
    TextStyle? hintStyle,
    this.labelText,
    TextStyle? labelStyle,
    this.inputFormatters,
    this.items,
    TextStyle? textStyle,
    this.setter,
    this.onValueChanged,
    this.itemsVisibleInDropdown = 3,
    this.strict = true,
    super.key,
  })  : hintStyle = hintStyle ??
            FontTheme.poppins18w400black().copyWith(
              color: BaseColors.gray3,
            ),
        labelStyle = labelStyle ?? FontTheme.poppins18w400black(),
        textStyle = textStyle ?? FontTheme.poppins18w400black(),
        super(
          initialValue: controller != null ? controller.text : (value ?? ''),
          onSaved: setter,
          builder: (FormFieldState<String> field) {
            final state = field as DropDownFieldState;
            final effectiveDecoration = InputDecoration(
              border: InputBorder.none,
              filled: true,
              icon: icon,
              suffixIcon: IconButton(
                icon: SvgPicture.asset(SvgIcons.dropdown, height: 24),
                onPressed: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  state.toggleDropDownVisibility();
                },
              ),
              hintStyle: hintStyle,
              labelStyle: labelStyle,
              hintText: hintText,
              labelText: labelText,
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CompositedTransformTarget(
                  link: state._layerLink,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: state._effectiveController,
                          focusNode: state._focusNode,
                          minLines: 1,
                          style: FontTheme.poppins12w400black(),
                          decoration: effectiveDecoration.copyWith(
                            contentPadding: const EdgeInsets.all(16),
                            border: const OutlineInputBorder(),
                            hintText: 'Contoh: UTS',
                          ),
                          textInputAction: TextInputAction.newline,
                          onChanged: (value) {
                            if (value.trim().isEmpty) {
                              controller?.text = '';
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required.';
                            }
                            onValidate();
                            return null;
                          },
                          onSaved: setter,
                          inputFormatters: inputFormatters,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );

  @override
  DropDownFieldState createState() => DropDownFieldState();
}

class DropDownFieldState extends FormFieldState<String> {
  late TextEditingController _controller;
  bool _showdropdown = false;
  String _searchText = '';
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  @override
  DropDownField get widget => super.widget as DropDownField;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  List<String> get _items => widget.items?.cast<String>() ?? [];

  void toggleDropDownVisibility() {
    if (_showdropdown) {
      _removeOverlay();
    } else {
      if (_searchText.isEmpty) {
        setState(() {
          _searchText = '';
        });
      }
      _showOverlay();
    }
    setState(() {
      _showdropdown = !_showdropdown;
    });
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;

    // Calculate the actual text field height (excluding error message)
    // Standard text field height with border and padding is approximately 56
    const textFieldHeight = 56.0;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, textFieldHeight),
          child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.itemsVisibleInDropdown * 36.0,
              ),
              decoration: const BoxDecoration(
                color: BaseColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: _items.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'No items available',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _getFilteredItems().length,
                      itemBuilder: (context, index) {
                        final item = _getFilteredItems()[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _effectiveController.text = item;
                              _handleControllerChanged();
                              _showdropdown = false;
                              widget.onValueChanged?.call(item);
                            });
                            _removeOverlay();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            child: Text(
                              item,
                              style: widget.textStyle?.copyWith(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getFilteredItems() {
    if (_searchText.isEmpty) {
      return _items;
    }
    return _items
        .where((item) => item.toUpperCase().contains(_searchText.toUpperCase()))
        .toList();
  }

  void clearValue() {
    setState(() {
      _effectiveController.text = '';
    });
  }

  @override
  void didUpdateWidget(DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _controller = TextEditingController();
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue ?? '');
    }

    _effectiveController.addListener(_handleControllerChanged);
    _focusNode.addListener(_handleFocusChange);

    _searchText = _effectiveController.text;
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus && _showdropdown) {
      setState(() {
        _showdropdown = false;
      });
      _removeOverlay();
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue ?? '';
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }

    if (Pref.getBool('doneAppTour') == false ||
        Pref.getBool('doneAppTour') == null) {
      return; // Prevent overlay shows on showcase!!
    }

    if (_effectiveController.text.isEmpty) {
      setState(() {
        _searchText = '';
        if (_showdropdown && _overlayEntry != null) {
          _removeOverlay();
          _showOverlay();
        }
      });
    } else {
      setState(() {
        _searchText = _effectiveController.text;
        if (_showdropdown && _overlayEntry != null) {
          _removeOverlay();
          _showOverlay();
        } else if (!_showdropdown) {
          _showdropdown = true;
          _showOverlay();
        }
      });
    }
  }
}
