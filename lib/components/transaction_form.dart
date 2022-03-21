import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_textField.dart';
import 'adaptative_datePicker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectDate == null) return;

    widget.onSubmit(title, value, _selectDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeDatePicker(
                selectedDate: _selectDate,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectDate = newDate;
                  });
                },
              ),
              AdaptativeTextField(
                label: 'Descrição',
                controller: _titleController,
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                controller: _valueController,
                keybordType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                submitForm: _submitForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AdaptativeButton(
                        label: 'Nova Transação', onPressed: _submitForm),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
