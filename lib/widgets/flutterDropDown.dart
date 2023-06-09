import 'package:flutter/material.dart';

class FlutterFlowDropDown extends StatefulWidget {
  const FlutterFlowDropDown({
    @required this.options,
    @required this.onChanged,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    this.textStyle,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.borderColor,
    this.margin,
    this.initialOption,
    bool? hidesUnderline,
  });

  final List<String>? options;
  final Function(String)? onChanged;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? fillColor;
  final TextStyle? textStyle;
  final double? elevation;
  final double? borderWidth;
  final double? borderRadius;
  final Color? borderColor;
  final String? initialOption;
  final EdgeInsetsGeometry? margin;

  @override
  State<FlutterFlowDropDown> createState() => _FlutterFlowDropDownState();
}

class _FlutterFlowDropDownState extends State<FlutterFlowDropDown> {
  late String dropDownValue;
  late List<String> effectiveOptions;

  @override
  void initState() {
    effectiveOptions = (widget.options!.isEmpty ? ['[Option]'] : widget.options)!;
    dropDownValue = (widget.initialOption ==""?effectiveOptions.first:widget.initialOption)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final childWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
        border: Border.all(
          color: widget.borderColor??Colors.black,
          width: widget.borderWidth??0,
        ),
        color: widget.fillColor,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
        child: DropdownButton<String>(
          value: dropDownValue,
          items: effectiveOptions
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: widget.textStyle,
            ),
          ))
              .toList(),
          elevation: widget.elevation!.toInt(),
          onChanged: (value) {
            dropDownValue = value!;
            widget.onChanged!(value);
          },
          icon: widget.icon,
          isExpanded: true,
          dropdownColor: widget.fillColor,
        ),
      ),
    );
    if (widget.height != null || widget.width != null) {
      return Container(
          width: widget.width, height: widget.height, child: childWidget);
    }
    return childWidget;
  }
}