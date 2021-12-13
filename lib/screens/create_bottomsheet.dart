import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:ta_caro/models/bottomsheet_controller.dart';
import 'package:ta_caro/models/button.dart';
import 'package:ta_caro/models/input.dart';

class CreateBottomsheet extends StatefulWidget {
  const CreateBottomsheet({Key? key}) : super(key: key);

  @override
  State<CreateBottomsheet> createState() => _CreateBottomsheetState();
}

class _CreateBottomsheetState extends State<CreateBottomsheet> {
  final controller = BottomsheetController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              InputText(
                label: "Produto",
                hint: "Digite um nome",
                validator: (value) =>
                    value.isNotEmpty ? null : 'Favor digitar um nome',
              ),
              SizedBox(
                height: 8,
              ),
              InputText(
                label: "Preço",
                hint: "Digite o valor",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value.isNotEmpty ? null : 'Favor digitar um valor',
                inputFormatters: [
                  MoneyInputFormatter(
                      leadingSymbol: 'R\$', useSymbolPadding: true)
                ],
              ),
              SizedBox(
                height: 8,
              ),
              InputText(
                label: "Data da compra",
                hint: "Digite dd/mm/aa",
                validator: (value) =>
                    value.isNotEmpty ? null : 'Favor digitar uma data',
                inputFormatters: [MaskedInputFormatter('00/00/00')],
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                  label: "Adicionar",
                  onTap: () {
                    controller.create();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
