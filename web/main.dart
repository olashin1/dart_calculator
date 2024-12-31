// ignore_for_file: non_constant_identifier_names

// note, dart:html is a legacy library, web.dart is the modern library
import 'dart:html';
import 'dart:js_interop';

// importing eval method from JS
@JS()
external num eval(String expression);

void main() {
  var numBtns = querySelectorAll('.num-btn');
  var opBtns = querySelectorAll('.operation-btn');
  var equalsBtn = querySelector('#equals');
  var result = querySelector('#output');
  var clearBtn = querySelector('.clear-btn');

  // output function
  void output_stream(var val) {
    result?.innerText += val;
  }

  void clear_stream() {
    result?.innerText = '';
  }

  // event listners for all number buttons
  for (var btn in numBtns) {
    btn.onClick.listen((event) {
      var value = (btn as ButtonElement).text;
      output_stream(value);
    });
  }

  // event listeners for operator buttons
  for (var btn in opBtns) {
    btn.onClick.listen((event) {
      var operator = (btn as ButtonElement).text;
      output_stream(operator);
    });
  }

  // event handler for equals button
  equalsBtn?.onClick.listen((event) {
    final expressionElement = querySelector('#output');
    final expressionVal = expressionElement?.text ?? '';
    // calling a js method
    try {
      final output = eval(expressionVal);
      // since the innerText element cant directly accept what the eval function gives,
      // we turn it to a string
      result?.innerText = output.toString(); // Replace display with result
    } catch (e) {
      result?.innerText = 'Error';
    }
  });

  // event handler for clear button
  clearBtn?.onClick.listen((event) {
    clear_stream();
  });
}
