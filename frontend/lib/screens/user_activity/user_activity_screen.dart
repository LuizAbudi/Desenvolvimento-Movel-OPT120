import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:opt120/screens/user_activity/user_activity_http_requests.dart';

class UserActivitiesTable extends StatefulWidget {
  final List<Map<String, dynamic>> userActivities;
  final List<Map<String, dynamic>> users;
  final List<Map<String, dynamic>> activities;

  UserActivitiesTable({
    required this.userActivities,
    required this.users,
    required this.activities,
  });

  @override
  _UserActivitiesTableState createState() => _UserActivitiesTableState();
}

class _UserActivitiesTableState extends State<UserActivitiesTable> {
  late int _userId = 0;
  late int _activityId = 0;
  late DateTime? _deliveryDate;
  late double _score = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        ElevatedButton(
          onPressed: () {
            _criarUsuarioAtividade();
          },
          child: Text('Criar Associação Usuário-Atividade'),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: DataTable(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ID do usuário',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ID da atividade',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Data de entrega',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Nota',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Ações',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            rows: widget.userActivities.map((userActivity) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userActivity['user_id'].toString()),
                        Text(' - '),
                        Text(widget.users.firstWhere((user) =>
                            user['id'] == userActivity['user_id'])['name']),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userActivity['activity_id'].toString()),
                        Text(' - '),
                        Text(widget.activities.firstWhere((activity) =>
                            activity['id'] ==
                            userActivity['activity_id'])['title']),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(
                            DateTime.parse(userActivity['delivery_date']),
                          ),
                        ),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userActivity['score'].toString()),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editarUsuarioAtividade(userActivity['user_id'],
                                  userActivity['activity_id'], userActivity);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletarUsuarioAtividade(userActivity['user_id'],
                                  userActivity['activity_id'], userActivity);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _criarUsuarioAtividade() {
    TextEditingController datePickerController = TextEditingController();

    onTapFunction({required BuildContext context}) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime(2101),
        firstDate: DateTime(2024),
        initialDate: DateTime.now(),
      );
      setState(() {
        _deliveryDate = pickedDate;
      });
      if (pickedDate == null) return;
      datePickerController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Criar Associação Usuário-Atividade'),
            content: Column(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Usuário'),
                  items: widget.users
                      .map((user) => DropdownMenuItem(
                            value: user['id'],
                            child: Text(user['name']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _userId = value as int;
                    });
                  },
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Atividade'),
                  items: widget.activities
                      .map((activity) => DropdownMenuItem(
                            value: activity['id'],
                            child: Text(activity['title']),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _activityId = value as int;
                    });
                  },
                ),
                TextField(
                  onTap: () => onTapFunction(context: context),
                  readOnly: true,
                  controller: datePickerController,
                  decoration: InputDecoration(
                    labelText: 'Data',
                    hintText: datePickerController.text.isEmpty
                        ? 'Selecione uma data'
                        : datePickerController.text,
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _score = double.parse(value);
                    });
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Nota',
                    hintText: 'Digite a nota',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  if (_score < 0 || _score > 10) {
                    return;
                  }
                  UserActivitiesService.createUserActivity(
                    _userId,
                    _activityId,
                    DateFormat('yyyy-MM-dd').format(_deliveryDate!),
                    _score,
                  );
                  Navigator.of(context).pop();
                  setState(() {
                    widget.userActivities.add({
                      'user_id': _userId,
                      'activity_id': _activityId,
                      'delivery_date':
                          DateFormat('yyyy-MM-dd').format(_deliveryDate!),
                      'score': _score,
                    });
                  });
                },
                child: Text('Salvar'),
              ),
            ],
          );
        });
  }

  void _editarUsuarioAtividade(
      int userId, int activityId, Map<String, dynamic> userActivity) {
    TextEditingController datePickerController = TextEditingController();

    onTapFunction({required BuildContext context}) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime(2101),
        firstDate: DateTime(2024),
        initialDate: DateTime.now(),
      );
      setState(() {
        _deliveryDate = pickedDate;
      });
      if (pickedDate == null) return;
      datePickerController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Usuário - Atividade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onTap: () => onTapFunction(context: context),
                readOnly: true,
                controller: datePickerController,
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: datePickerController.text.isEmpty
                      ? 'Selecione uma data'
                      : datePickerController.text,
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _score = double.parse(value);
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Nota',
                  hintText: 'Digite a nota',
                ),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                UserActivitiesService.updateUserActivity(
                  userId,
                  activityId,
                  DateFormat('yyyy-MM-dd').format(_deliveryDate!),
                  _score.toInt(),
                );
                Navigator.of(context).pop();
                setState(() {
                  widget.userActivities.removeWhere((element) =>
                      element['user_id'] == userId &&
                      element['activity_id'] == activityId);
                  widget.userActivities.add({
                    'user_id': userId,
                    'activity_id': activityId,
                    'delivery_date':
                        DateFormat('yyyy-MM-dd').format(_deliveryDate!),
                    'score': _score,
                  });
                });
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deletarUsuarioAtividade(
      int userId, int activityId, Map<String, dynamic> userActivity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar Usuário - Atividade'),
          content: Text('Tem certeza que deseja deletar essa associação?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                UserActivitiesService.deleteUserActivity(userId, activityId);
                Navigator.of(context).pop();
                setState(() {
                  widget.userActivities.removeWhere((element) =>
                      element['user_id'] == userId &&
                      element['activity_id'] == activityId);
                });
              },
              child: Text('Deletar'),
            ),
          ],
        );
      },
    );
  }
}
