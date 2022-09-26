import 'package:bytebank_app/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon;
  }
  return false;
}

bool contactFormTextFieldMatcher(Widget widget, String label) {
  if (widget is TextField) {
    return widget.decoration?.labelText == label;
  }
  return false;
}
