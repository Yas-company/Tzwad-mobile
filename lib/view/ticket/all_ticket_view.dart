import 'package:flutter/material.dart';
import '../../service/add_new_ticket_service.dart';
import '../../view/ticket/add_new_ticket.dart';
import '../../view/ticket/ticket_tile.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_name.dart';
import '../../view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

import '../../service/ticket_service.dart';
import '../utils/constant_colors.dart';

class AllTicketsView extends StatelessWidget {
  static const routeName = 'all tickets';
  AllTicketsView({Key? key}) : super(key: key);

  ConstantColors cc = ConstantColors();

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    controller.addListener((() => scrollListener(context)));
    initiateDeviceSize(context);
    double cardWidth = screenWidth / 3.3;
    double cardHeight = screenHight / 4.9;

    return Scaffold(
        appBar: AppBars()
            .appBarTitled(context, asProvider.getString('All tickets'), () {
          Provider.of<TicketService>(context, listen: false).clearTickets();
          Navigator.of(context).pop();
        }),
        body: WillPopScope(
            onWillPop: () async {
              Provider.of<TicketService>(context, listen: false).clearTickets();
              Navigator.of(context).pop();
              return true;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: Provider.of<TicketService>(context, listen: false)
                          .fetchTickets(noForceFetch: false),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return loadingProgressBar();
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              asProvider.getString('Something went wrong!'),
                              style: TextStyle(color: cc.greyHint),
                            ),
                          );
                          ;
                        }
                        if (snapshot.hasData) {
                          return Center(
                            child:
                                Text(asProvider.getString('No ticket found.')),
                          );
                        }
                        return Consumer<TicketService>(
                            builder: (context, ticketsService, child) {
                          return ticketsService.noProduct
                              ? Center(
                                  child: Text(
                                      asProvider.getString('No ticket found.')),
                                )
                              : ticketsListView(
                                  cardWidth, cardHeight, ticketsService);
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: customContainerButton(
                      asProvider.getString('Add new ticket'), double.infinity,
                      () {
                    Provider.of<AddNewTicketService>(context, listen: false)
                        .fetchDepartments()
                        .onError((error, stackTrace) => snackBar(
                            context, asProvider.getString('Connection failed!'),
                            backgroundColor: cc.orange));
                    Navigator.of(context)
                        .pushNamed(AddNewTicket.routeName)
                        .then((value) {
                      Provider.of<AddNewTicketService>(context, listen: false)
                          .clearAllData();
                      Provider.of<TicketService>(context, listen: false)
                          .fetchTickets(noForceFetch: true);
                    });
                  }),
                ),
                const SizedBox(height: 40),
              ],
              // ),
            )));
  }

  Widget ticketsListView(
      double cardWidth, double cardHeight, TicketService ticketsService) {
    if (ticketsService.noProduct) {
      return Center(
        child: Text(
          asProvider.getString('No data has been found!'),
          style: TextStyle(color: cc.greyHint),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: controller,
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 30, top: 10),
                // controller: controller,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: ticketsService.ticketsList.length,
                itemBuilder: (context, index) {
                  return TicketTile(
                    ticketsService.ticketsList[index].title,
                    ticketsService.ticketsList[index].id,
                    ticketsService.ticketsList[index].createdAt,
                    ticketsService.ticketsList[index].priority,
                    ticketsService.ticketsList[index].status,
                    ticketsService.ticketsList[index].id !=
                        ticketsService.ticketsList.last.id,
                  );
                }),
          ),
          if (ticketsService.nextPage)
            Center(
              child: loadingProgressBar(),
            ),
        ],
      );
    }
  }

  scrollListener(BuildContext context) async {
    final tService = Provider.of<TicketService>(context, listen: false);
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (tService.ticketsModel!.nextPageUrl != null && !tService.nextPage) {
        tService.setNextPage(true);
        await tService
            .fetchNextPage(noForceFetch: false)
            .then((value) => tService.setNextPage(false))
            .onError((error, stackTrace) => tService.setNextPage(false));
        return;
      }
      snackBar(context, asProvider.getString('No more ticket found'),
          backgroundColor: cc.orange);
    }
  }
}
