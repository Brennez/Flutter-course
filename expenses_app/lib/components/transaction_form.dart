import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/theme.dart';
import 'transaction_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  final void Function(BuildContext context) onCloseModal;

  const TransactionForm(
      {super.key, required this.onSubmit, required this.onCloseModal});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _submitForm() {
      final newTitle = _titleController.text;
      final newValue = double.tryParse(_valueController.text) ?? 0.0;

      if (newTitle.isEmpty || newValue < 0) {
        return;
      }

      widget.onSubmit(newTitle, newValue, _selectedDate);
    }

    _showDatePicker() async {
      var newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
        confirmText: 'Confirmar',
        cancelText: 'Cancelar',
        // helpText: 'Selecione a data da despesa',
      );
      if (newDate == null) {
        return;
      }
      setState(() {
        _selectedDate = newDate;
      });
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Text(
              "Adicione uma transação",
              style: myTheme.textTheme.titleLarge!.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.purple,
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _submitForm(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Título',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: myTheme.colorScheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: myTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.purple,
                  ),
                  controller: _valueController,
                  onSubmitted: (_) => _submitForm(),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: 'Valor',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: myTheme.colorScheme.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: myTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: _selectedDate != null
                            ? Text(
                                'Data: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                                style: myTheme.textTheme.displaySmall!.copyWith(
                                  color: myTheme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text('Data nula')),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: _showDatePicker,
                      child: Row(
                        children: [
                          Text(
                            'Selecionar Data',
                            style: myTheme.textTheme.displaySmall!.copyWith(
                              color: myTheme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: myTheme.colorScheme.primary,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          backgroundColor: Colors.red[600],
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => widget.onCloseModal(context),
                    ),
                  ),
                  AdaptativeButton(
                    label: 'Adicionar transação',
                    onPressed: _submitForm,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
