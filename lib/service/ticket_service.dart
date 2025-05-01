import 'dart:convert';

import 'package:flutter/material.dart';
import '../../model/tickets_model.dart';
import '../../service/common_service.dart';
import '../../view/utils/constant_name.dart';
import 'package:http/http.dart' as http;

class TicketService with ChangeNotifier {
  List<Datum> ticketsList = [];
  bool isLoading = false;
  bool? lastPage;
  TicketsModel? ticketsModel;
  bool noProduct = false;
  bool nextPage = false;
  int pageNo = 1;
  String? title;
  String? subject;

  String priority = 'Low';
  String department = 'Product Delivery';
  int? departmentId;
  String? description;
  Map<String, Color> priorityColor = {
    'low': const Color(0xff6BB17B),
    'medium': const Color(0xff70B9AE),
    'high': const Color(0xffBFB55A),
    'urgent': const Color(0xffC66060),
  };

  List<String> priorityList = [
    'low',
    'medium',
    'high',
    'urgent',
  ];
  List<Ddata> departmentsList = [];

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  setNextPage(value) {
    if (value == nextPage) {
      return;
    }
    nextPage = value;
    notifyListeners();
  }

  setPageNo() {
    pageNo++;
    notifyListeners();
  }

  // setSelectedTicket(value) {
  //   selectedTicket = value;
  //   notifyListeners();
  // }

  setPriority(value) {
    priority = value;
    notifyListeners();
  }

  setDepartment(value) {
    department = value;
    notifyListeners();
  }

  setTitle(value) {
    title = value;
    notifyListeners();
  }

  setSubject(value) {
    subject = value;
    notifyListeners();
  }

  setDescription(value) {
    description = value;
    notifyListeners();
  }

  clearTickets() {
    ticketsList = [];
    noProduct = false;
  }

  Future fetchTickets({bool noForceFetch = true}) async {
    print(noProduct);
    if (!noForceFetch) {
      // if (lastPage != null && lastPage!) {
      //   setIsLoading(false);
      //   notifyListeners();
      //   print('Leaving fetching___________');
      //   return 'No more product found!';
      // }
      noForceFetch = true;
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        'Content-Type': 'application/json',
        "Authorization": "Bearer $globalUserToken",
      };
      final url = Uri.parse('$baseApiUrl/user/ticket');
      try {
        final response = await http.get(url, headers: header);
        if (response.statusCode == 200) {
          var data = TicketsModel.fromJson(jsonDecode(response.body));
          ticketsModel = data;
          ticketsList = data.data;
          setIsLoading(false);
          noProduct = ticketsList.isEmpty;

          if (ticketsList.isEmpty) {
            print(ticketsList.isEmpty);
            noProduct = true;
            notifyListeners();
            return 'null';
          }
          notifyListeners();
          return;
        }
        throw '';
      } catch (error) {
        print(error);

        rethrow;
      }
    }
  }

  Future fetchNextPage({bool noForceFetch = true}) async {
    print(noProduct);
    if (!noForceFetch) {
      // if (lastPage != null && lastPage!) {
      //   setIsLoading(false);
      //   notifyListeners();
      //   print('Leaving fetching___________');
      //   return 'No more product found!';
      // }
      noForceFetch = true;
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        'Content-Type': 'application/json',
        "Authorization": "Bearer $globalUserToken",
      };
      final url = Uri.parse(ticketsModel!.nextPageUrl);
      try {
        final response = await http.get(url, headers: header);
        print(response.body);
        if (response.statusCode == 200) {
          var data = TicketsModel.fromJson(jsonDecode(response.body));
          data.data.forEach((element) {
            ticketsList.add(element);
          });
          ticketsModel = data;
          notifyListeners();
          return;
        }
        throw '';
      } catch (error) {
        print(error);

        rethrow;
      }
    }
  }

  Future getDepartments() async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };
    print('searching in progress');
    final url = Uri.parse('$baseApiUrl/user/get-department');
    print(url);
    try {
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        var data = TicketDepartments.fromJson(jsonDecode(response.body));
        departmentsList = data.departmentsData;
        department = departmentsList[0].name;
        departmentId = departmentsList[0].id;
        setIsLoading(false);

        notifyListeners();
      } else {}
    } catch (error) {
      print(error);

      rethrow;
    }
  }

  Future statusChange(int id, String status) async {
    print('sending------------------');
    final url = Uri.parse('$baseApiUrl/user/ticket/status-change');

    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };

    final response = await http.post(url, headers: header, body: {
      'status': status.toLowerCase(),
      'id': id.toString(),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      ticketsList.firstWhere((element) => element.id == id).status =
          status.toLowerCase();
      notifyListeners();
      return;
    }
    return asProvider.getString('Status change failed');
  }

  Future priorityChange(int id, String value) async {
    print('sending------------------');
    final url = Uri.parse('$baseApiUrl/user/ticket/priority-change');

    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };

    final response = await http.post(url, headers: header, body: {
      'priority': value.toLowerCase(),
      'id': id.toString(),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      ticketsList.firstWhere((element) => element.id == id).priority =
          value.toLowerCase();
      notifyListeners();
      return;
    }
    return asProvider.getString('Status change failed');
  }
}

TicketDepartments ticketDepartmentsFromJson(String str) =>
    TicketDepartments.fromJson(json.decode(str));

String ticketDepartmentsToJson(TicketDepartments departmentsData) =>
    json.encode(departmentsData.toJson());

class TicketDepartments {
  TicketDepartments({
    required this.departmentsData,
  });

  List<Ddata> departmentsData;

  factory TicketDepartments.fromJson(Map<String, dynamic> json) =>
      TicketDepartments(
        departmentsData:
            List<Ddata>.from(json["data"].map((x) => Ddata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(departmentsData.map((x) => x.toJson())),
      };
}

class Ddata {
  Ddata({
    required this.id,
    required this.name,
    required this.status,
  });

  dynamic id;
  String name;
  String status;

  factory Ddata.fromJson(Map<String, dynamic> json) => Ddata(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
