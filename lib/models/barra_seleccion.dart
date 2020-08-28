import 'package:flutter/material.dart';

class BarraSeleccion extends ButtonBar{


  BarraSeleccion(
      {Key key,
        MainAxisAlignment alignment,
        MainAxisSize mainAxisSize,
        ButtonTextTheme buttonTextTheme,
        double buttonMinWidth,
        double buttonHeight,
        EdgeInsetsGeometry buttonPadding,
        bool buttonAlignedDropdown,
        ButtonBarLayoutBehavior layoutBehavior,
        VerticalDirection overflowDirection,
        double overflowButtonSpacing,
        List<Widget> children: const []}
      );
}